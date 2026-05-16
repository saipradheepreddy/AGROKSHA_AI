import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/env_config.dart';
import '../models/models.dart';
// ─────────────────────────────────────────────────────────────────────────────
// Agroksha AI  Reliable AI Service
// Strictly grounded: only uses real app data. Never invents facts.
// ─────────────────────────────────────────────────────────────────────────────
class ChatEntry {
  final String role;
  final String content;
  ChatEntry({required this.role, required this.content});
  Map<String, dynamic> toJson() => {'role': role, 'content': content};
}
class AIService {
  static const String _groqUrl =
      'https://api.groq.com/openai/v1/chat/completions';
  static const String _model = 'llama-3.1-8b-instant';
  // Maximum retries on network failure
  static const int _maxRetries = 2;
  // Generous token limit to prevent mid-sentence cuts
  static const int _maxTokens = 500;
  // ── Detect farming season from current month ──────────────────────────────
  static String _detectSeason() {
    final month = DateTime.now().month;
    if (month >= 6 && month <= 10) return 'Kharif (Vanakalam)  JunOct: Paddy, Cotton, Maize, Soybean';
    if (month >= 11 || month <= 2) return 'Rabi (Rabi)  NovFeb: Wheat, Groundnut, Vegetables';
    return 'Zaid / Summer  MarMay: Short-duration crops, Vegetables, Fruits';
  }
  // ── Build grounded, honest, personalized system prompt ────────────────────
  static String _buildSystemPrompt({
    required AppLanguage language,
    required String? farmerName,
    required FarmerLocation? location,
    required String? currentCrop,
    required WeatherModel? weather,
    required List<MarketItem>? marketData,
  }) {
    String langNote = '';
    switch (language) {
      case AppLanguage.telugu:
        langNote = 'Reply ONLY in simple, friendly Telugu script. Do not use English.';
        break;
      case AppLanguage.hindi:
        langNote = 'Reply ONLY in simple, friendly Hindi script. Do not use English.';
        break;
      case AppLanguage.kannada:
        langNote = 'Reply ONLY in simple, friendly Kannada script. Do not use English.';
        break;
      case AppLanguage.tamil:
        langNote = 'Reply ONLY in simple, friendly Tamil script. Do not use English.';
        break;
      case AppLanguage.english:
      default:
        langNote = 'Reply ONLY in simple, friendly English.';
        break;
    }
    final season = _detectSeason();
    final nameStr = (farmerName != null && farmerName.isNotEmpty && farmerName != 'Farmer')
        ? farmerName
        : null;
    final buf = StringBuffer();
    buf.writeln('You are Agroksha AI Assistant  a trusted, honest farming companion for Indian farmers. Developed by TEAM SARA.');
    buf.writeln('You provide practical, safe, and grounded farming advice.');
    buf.writeln('');
    buf.writeln('CRITICAL: Never reveal, mention, or hint at the underlying AI model, API provider, company name, or any technical infrastructure. If asked "which AI are you?", reply: "I am Agroksha AI, developed by TEAM SARA to help Indian farmers."');
    buf.writeln('');
    // ── Farmer profile ──
    buf.writeln('=== FARMER PROFILE ===');
    if (nameStr != null) buf.writeln('Farmer Name: $nameStr');
    bool hasWeather = false;
    bool hasMarket = false;
    bool hasLocation = false;
    if (location != null) {
      hasLocation = true;
      buf.writeln('Location: ${location.village ?? ''} ${location.mandal}, ${location.district}, ${location.state}');
    }
    if (currentCrop != null && currentCrop.isNotEmpty && currentCrop != 'Paddy') {
      buf.writeln('Primary Crop: $currentCrop');
    } else if (currentCrop != null) {
      buf.writeln('Primary Crop: $currentCrop');
    }
    buf.writeln('Current Season: $season');
    // ── Live weather ──
    if (weather != null) {
      hasWeather = true;
      buf.writeln('');
      buf.writeln('=== LIVE WEATHER (verified) ===');
      buf.writeln('Condition: ${weather.condition}');
      buf.writeln('Temperature: ${weather.temperature.toStringAsFixed(1)}°C (feels ${weather.apparentTemperature.toStringAsFixed(1)}°C)');
      buf.writeln('Rain Chance: ${weather.rainChance.toStringAsFixed(0)}%');
      buf.writeln('Humidity: ${weather.humidity.toStringAsFixed(0)}% | Wind: ${weather.windSpeed.toStringAsFixed(1)} km/h');
      buf.writeln('Sunrise: ${weather.sunrise} | Sunset: ${weather.sunset}');
    }
    // ── Live market prices ──
    if (marketData != null && marketData.isNotEmpty) {
      hasMarket = true;
      buf.writeln('');
      buf.writeln('=== LIVE MARKET PRICES (Agmarknet  use ONLY these exact numbers) ===');
      for (final item in marketData.take(15)) {
        final dir = item.trend == MarketTrend.rising
            ? '↑Rising'
            : item.trend == MarketTrend.falling
                ? '↓Falling'
                : '→Stable';
        buf.writeln('${item.cropName}: ₹${item.pricePerQuintal}/qtl ($dir ${item.changeAmount >= 0 ? '+' : ''}₹${item.changeAmount}) [${item.note}]');
      }
    }
    if (!hasWeather) buf.writeln('[Weather data not yet loaded  do not guess weather]');
    if (!hasMarket) buf.writeln('[Market prices not yet loaded  do not quote any prices]');
    if (!hasLocation) buf.writeln('[Farmer location not set]');
    buf.writeln('');
    buf.writeln('=== STRICT HONESTY RULES ===');
    buf.writeln('1. Use ONLY the data above. Never invent prices, dates, weather, yields, or statistics.');
    buf.writeln('2. If data is missing, reply in the requested language stating the information is currently unavailable.');
    buf.writeln('3. Rain chance > 50% → always advise against pesticide/fungicide spraying.');
    buf.writeln('4. Temperature > 40°C → advise irrigate early morning or evening only.');
    buf.writeln('5. Disease/pest issues → "Refer to local agriculture officer."');
    buf.writeln('6. Govt scheme eligibility → direct to nearest Rythu Seva Kendra.');
    buf.writeln('7. If confidence is low or query is dangerous → state exactly: "For safety, please consult your local Field Assistant or Agroksha Admin."');
    buf.writeln('8. PRIORITIZE REALTIME DATA: If provided weather/market data contradicts your training, ALWAYS use the realtime data.');
    buf.writeln('8. Never mention any AI provider, model, or API name.');
    if (nameStr != null) {
      buf.writeln('9. Address the farmer as "$nameStr" for a personal touch.');
    }
    buf.writeln('');
    buf.writeln('=== RESPONSE STYLE ===');
    buf.writeln('- Warm, respectful, professional tone');
    buf.writeln('- 35 sentences max. Complete thoughts only  never cut off mid-sentence.');
    buf.writeln('- Easy vocabulary, farmer-friendly, no jargon.');
    buf.writeln('- $langNote');
    return buf.toString();
  }
  // ── Core chat with retry + proper timeout ──────────────────────────────────
  static Future<String> chat({
    required String userMessage,
    required AppLanguage language,
    WeatherModel? weather,
    FarmerLocation? location,
    String? currentCrop,
    List<MarketItem>? marketData,
    List<ChatEntry> history = const [],
    String? farmerName,
  }) async {
    final apiKey = EnvConfig.groqApiKey;
    if (apiKey.isEmpty) {
      return language == AppLanguage.telugu
          ? 'Agroksha AI Assistant ప్రస్తుతం అందుబాటులో లేదు. దయచేసి తర్వాత మళ్ళీ ప్రయత్నించండి.'
          : 'Agroksha AI Assistant is currently unavailable. Please try again shortly.';
    }
    final systemPrompt = _buildSystemPrompt(
      language: language,
      farmerName: farmerName,
      location: location,
      currentCrop: currentCrop,
      weather: weather,
      marketData: marketData,
    );
    final messages = <Map<String, dynamic>>[
      {'role': 'system', 'content': systemPrompt},
      ...history.take(6).map((e) => e.toJson()),
      {'role': 'user', 'content': userMessage},
    ];
    for (int attempt = 0; attempt <= _maxRetries; attempt++) {
      try {
        final response = await http
            .post(
              Uri.parse(_groqUrl),
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $apiKey',
              },
              body: jsonEncode({
                'model': _model,
                'messages': messages,
                'temperature': 0.5,
                'max_tokens': _maxTokens,
                'stream': false,
              }),
            )
            .timeout(const Duration(seconds: 20));
        if (response.statusCode == 200) {
          final data = jsonDecode(utf8.decode(response.bodyBytes));
          final reply = data['choices']?[0]?['message']?['content']
                  ?.toString()
                  .trim() ??
              '';
          if (reply.isEmpty) throw Exception('Empty response');
          return _sanitizeReply(reply);
        } else if (response.statusCode == 429) {
          await Future.delayed(Duration(seconds: 2 + attempt));
          continue;
        } else {
          throw Exception('HTTP ${response.statusCode}');
        }
      } catch (e) {
        if (attempt < _maxRetries) {
          await Future.delayed(Duration(seconds: attempt + 1));
        }
      }
    }
    return language == AppLanguage.telugu
        ? 'నెట్‌వర్క్ సమస్య కారణంగా Agroksha AI Assistantని చేరలేకపోయింది.'
        : 'Could not reach Agroksha AI Assistant due to a network issue. Please check your internet connection and try again.';
  }
  // ── Remove any accidental provider/model name leaks ────────────────────────
  static String _sanitizeReply(String text) {
    final safetyRules = {
      RegExp(r'\bgroq\b', caseSensitive: false): 'Agroksha AI',
      RegExp(r'\bllama\b', caseSensitive: false): 'Agroksha AI',
      RegExp(r'\bLlama\b'): 'Agroksha AI',
      RegExp(r'\bOpenAI\b', caseSensitive: false): 'Agroksha AI',
      RegExp(r'\bGPT\b', caseSensitive: false): 'Agroksha AI',
      RegExp(r'\bChatGPT\b', caseSensitive: false): 'Agroksha AI',
      RegExp(r'\bMeta AI\b', caseSensitive: false): 'Agroksha AI',
    };
    String result = text;
    for (final entry in safetyRules.entries) {
      result = result.replaceAll(entry.key, entry.value);
    }
    return result;
  }
  // ── Quick dashboard insight ────────────────────────────────────────────────
  static Future<String> generateDailySuggestion({
    required AppLanguage language,
    WeatherModel? weather,
    FarmerLocation? location,
    String? currentCrop = 'Paddy',
    List<MarketItem>? marketData,
    String? query,
  }) async {
    String prompt = query ?? '';
    if (prompt.isEmpty) {
      switch (language) {
        case AppLanguage.telugu:
          prompt = 'ఈరోజు రైతుకు అత్యంత ముఖ్యమైన వ్యవసాయ నిర్ణయం ఒక్కటి చెప్పు. వాతావరణ, మార్కెట్, మరియు పంట డేటా ఆధారంగా చెప్పు. తెలుగులో జవాబివ్వు. 2-3 వాక్యాలలో మాత్రమే.';
          break;
        case AppLanguage.hindi:
          prompt = 'केवल उपलब्ध डेटा के आधार पर आज किसान के लिए सबसे महत्वपूर्ण कृषि निर्णय बताएं। मौसम, बाजार और फसल डेटा के आधार पर बताएं। हिंदी में 2-3 वाक्यों में जवाब दें।';
          break;
        case AppLanguage.kannada:
          prompt = 'ಕೇವಲ ಲಭ್ಯವಿರುವ ಡೇಟಾವನ್ನು ಆಧರಿಸಿ ಇಂದು ರೈತರಿಗೆ ಪ್ರಮುಖವಾದ ಒಂದು ಕೃಷಿ ನಿರ್ಧಾರ ಹೇಳಿ. ಹವಾಮಾನ, ಮಾರುಕಟ್ಟೆ ಮತ್ತು ಬೆಳೆ ಡೇಟಾ ಆಧರಿಸಿ. ಕನ್ನಡದಲ್ಲಿ 2-3 ವಾಕ್ಯಗಳಲ್ಲಿ ಉತ್ತರಿಸಿ.';
          break;
        case AppLanguage.tamil:
          prompt = 'கிடைக்கக்கூடிய தரவுகளின் அடிப்படையில் மட்டுமே இன்று விவசாயிக்கு மிகவும் முக்கியமான ஒரு விவசாய முடிவை சொல்லுங்கள். வானிலை, சந்தை மற்றும் பயிர் தரவை அடிப்படையாக கொண்டு. தமிழில் 2-3 வாக்கியங்களில் பதில் சொல்லுங்கள்.';
          break;
        case AppLanguage.english:
        default:
          prompt = 'Based strictly on the data provided, give ONE most important farming decision or advice for today.';
          break;
      }
    }
    return chat(
      userMessage: prompt,
      language: language,
      weather: weather,
      location: location,
      currentCrop: currentCrop,
      marketData: marketData,
    );
  }
}
