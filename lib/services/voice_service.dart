/// ─────────────────────────────────────────────────────────────────────────────









/// Agroksha AI  Premium Voice Service









/// Auto-selects best available native Telugu/English voice on device









/// ─────────────────────────────────────────────────────────────────────────────



















import 'dart:math';









import 'package:flutter/foundation.dart';









import 'package:flutter_tts/flutter_tts.dart';









import 'package:speech_to_text/speech_to_text.dart' as stt;









import '../models/models.dart';



















class VoiceService {









  static final VoiceService _instance = VoiceService._internal();









  factory VoiceService() => _instance;



















  final FlutterTts _tts = FlutterTts();









  final stt.SpeechToText _speech = stt.SpeechToText();



















  bool _isTtsInitialized = false;









  bool _isSttInitialized = false;









  bool _isPlaying = false;









  bool _isListening = false;



















  // Currently selected voice names (auto-detected)









  String? _bestTeluguVoice;









  String? _bestEnglishVoice;



















  // Available voices fetched from device









  List<Map<String, String>> _availableVoices = [];



















  VoiceService._internal();



















  bool get isPlaying => _isPlaying;









  bool get isListening => _isListening;









  List<Map<String, String>> get availableVoices => _availableVoices;









  String? get currentTeluguVoice => _bestTeluguVoice;



















  // ── 1. Init TTS + auto-select best voices ─────────────────────────────────









  Future<void> _initTts() async {









    if (_isTtsInitialized) return;









    try {









      await _tts.setVolume(1.0);









      await _tts.setSpeechRate(0.45);









      await _tts.setPitch(1.0);









      await _tts.awaitSpeakCompletion(false);



















      _tts.setStartHandler(() => _isPlaying = true);









      _tts.setCompletionHandler(() => _isPlaying = false);









      _tts.setCancelHandler(() => _isPlaying = false);









      _tts.setErrorHandler((msg) {









        _isPlaying = false;









        // [prod cleaned]









      });



















      // Fetch all available voices and pick the best ones









      await _discoverBestVoices();



















      _isTtsInitialized = true;









    } catch (e) {









      // [prod cleaned]









    }









  }



















  // ── Auto-discover best available native voices ────────────────────────────









  Future<void> _discoverBestVoices() async {









    try {









      final voices = await _tts.getVoices;









      if (voices == null) return;



















      _availableVoices = (voices as List)









          .map((v) => Map<String, String>.from(v as Map))









          .toList();



















      // Priority order for Telugu voices (Google high quality > Google > system)









      final teluguPriority = [









        'te-in-x-tec-network', // Google network (best)









        'te-in-x-tec-local',   // Google local









        'te_IN_#female',









        'te_IN_#male',









        'te-in',









        'te_IN',









      ];



















      // Priority for English (Indian accent)









      final englishPriority = [









        'en-in-x-ene-network',









        'en-in-x-ene-local',









        'en_IN_#female',









        'en_IN_#male',









        'en-in',









        'en_IN',









        'en-us-x-sfg-network',









      ];



















      for (final preferred in teluguPriority) {









        final match = _availableVoices.firstWhere(









          (v) =>









              (v['name']?.toLowerCase() ?? '').contains(preferred.toLowerCase()) ||









              (v['locale']?.toLowerCase() ?? '').contains('te'),









          orElse: () => {},









        );









        if (match.isNotEmpty) {









          _bestTeluguVoice = match['name'];









          break;









        }









      }



















      for (final preferred in englishPriority) {









        final match = _availableVoices.firstWhere(









          (v) =>









              (v['name']?.toLowerCase() ?? '').contains(preferred.toLowerCase()) ||









              ((v['locale']?.toLowerCase() ?? '').contains('en_in') ||









               (v['locale']?.toLowerCase() ?? '').contains('en-in')),









          orElse: () => {},









        );









        if (match.isNotEmpty) {









          _bestEnglishVoice = match['name'];









          break;









        }









      }



















      // [prod cleaned]









      // [prod cleaned]









    } catch (e) {









      // [prod cleaned]









    }









  }



















  // ── List Telugu voices available on device ────────────────────────────────









  List<Map<String, String>> get teluguVoices => _availableVoices









      .where((v) =>









          (v['locale']?.toLowerCase() ?? '').contains('te') ||









          (v['name']?.toLowerCase() ?? '').contains('te'))









      .toList();



















  // ── Set a specific voice by name ─────────────────────────────────────────









  Future<void> setTeluguVoice(String voiceName) async {









    _bestTeluguVoice = voiceName;









    await _tts.setVoice({'name': voiceName, 'locale': 'te-IN'});









  }



















  // ── 2. Init STT ───────────────────────────────────────────────────────────









  Future<bool> _initStt() async {









    if (_isSttInitialized) return true;









    try {









      _isSttInitialized = await _speech.initialize(









        onError: (err) => debugPrint('STT Error: $err'),









        onStatus: (status) => debugPrint('STT Status: $status'),









      );









      return _isSttInitialized;









    } catch (e) {









      // [prod cleaned]









      return false;









    }









  }



















  // ── 3. Core Speak  uses best native voice ─────────────────────────────────









  Future<void> speak(









    String text, {









    AppLanguage language = AppLanguage.telugu,









    int speed = 1,









  }) async {









    if (text.trim().isEmpty) return;









    await _initTts();



















    // Natural pacing  slightly slower for Telugu clarity









    double rate;









    switch (speed) {









      case 0: rate = 0.35; break;  // Slow  for elderly farmers









      case 2: rate = 0.52; break;  // Fast









      default: rate = 0.42;        // Normal  best for natural sound









    }



















    final pitch = language == AppLanguage.telugu ? 0.95 : 1.0;



















    await _tts.setPitch(pitch);









    await _tts.setSpeechRate(rate);



















    if (language == AppLanguage.telugu) {









      await _tts.setLanguage('te-IN');









      if (_bestTeluguVoice != null) {









        await _tts.setVoice({'name': _bestTeluguVoice!, 'locale': 'te-IN'});









      }









    } else {









      await _tts.setLanguage('en-IN');









      if (_bestEnglishVoice != null) {









        await _tts.setVoice({'name': _bestEnglishVoice!, 'locale': 'en-IN'});









      }









    }



















    // Split very long texts into sentences for smoother delivery









    if (text.length > 300) {









      final sentences = _splitIntoSentences(text);









      for (final sentence in sentences) {









        if (sentence.trim().isNotEmpty) {









          await _tts.speak(sentence.trim());









        }









      }









    } else {









      await _tts.speak(text);









    }









  }



















  /// Splits text at sentence boundaries to prevent TTS cut-offs









  List<String> _splitIntoSentences(String text) {









    // Split on Telugu danda (।), English period, or newlines









    return text









        .split(RegExp(r'(?<=[.।!\?])\s+'))









        .where((s) => s.trim().isNotEmpty)









        .toList();









  }



















  Future<void> stop() async {









    await _tts.stop();









    _isPlaying = false;









  }



















  // ── 4. STT Listen ─────────────────────────────────────────────────────────









  Future<void> startListening({









    required Function(String) onResult,









    required AppLanguage language,









  }) async {









    final ready = await _initStt();









    if (!ready) return;



















    if (_isPlaying) await stop();









    _isListening = true;



















    final listenOptions = stt.SpeechListenOptions(









      cancelOnError: true,









      listenMode: stt.ListenMode.confirmation,









    );



















    await _speech.listen(









      onResult: (result) {









        if (result.finalResult) {









          _isListening = false;









          onResult(result.recognizedWords);









        }









      },









      localeId: language == AppLanguage.telugu ? 'te_IN' : 'en_IN',









      listenOptions: listenOptions,









    );









  }



















  Future<void> stopListening() async {









    await _speech.stop();









    _isListening = false;









  }



















  // ── Test voice (for settings page) ────────────────────────────────────────









  Future<void> testVoice(AppLanguage language) async {









    String testMsg = '';









    switch (language) {









      case AppLanguage.telugu:









        testMsg = 'నమస�?కారం రైత�? అన�?నా! నేన�? Agroksha AI అసిస�?టెంట�?‌ని.';









        break;









      case AppLanguage.hindi:









        testMsg = 'नमस�?ते किसान भाई! मैं आपका Agroksha AI सहायक हू�?।';









        break;









      case AppLanguage.kannada:









        testMsg = 'ನಮಸ�?ಕಾರ ರೈತರೆ! ನಾನ�? ನಿಮ�?ಮ Agroksha AI ಸಹಾಯಕ.';









        break;









      case AppLanguage.tamil:









        testMsg = 'வணக�?கம�? விவசாயி! நான�? உங�?கள�? Agroksha AI உதவியாளர�?.';









        break;









      case AppLanguage.english:









      default:









        testMsg = 'Hello farmer! I am your Agroksha AI Assistant.';









        break;









    }









    await speak(testMsg, language: language);









  }



















  // �?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?









  // CONTEXT-BASED VOICE MESSAGES









  // �?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?�?



















  String getRandomGreeting(AppLanguage lang) {




    final rand = Random().nextInt(5);




    switch (lang) {




      case AppLanguage.telugu:




        final list = [




          'నమస్కారం రైతు బంధూ! ఈరోజు మీకు ఏ విధంగా సహాయపడగలను?',




          'స్వాగతం రైతు అన్నా! ఈరోజు పంట, వాతావరణం, మార్కెట్ గురించి మాట్లాడుదాం.',




          'నమస్కారం! మీ Agroksha AI అసిస్టెంట్ సిద్ధంగా ఉంది.',




          'రైతు బంధూ స్వాగతం! ఈరోజు వ్యవసాయంలో ఏమైనా సహాయం కావాలా?',




          'నమస్కారం. మీ పంట మరియు మార్కెట్ సమాచారం అందుబాటులో ఉంది.',




        ];




        return list[rand];




      case AppLanguage.hindi:




        final list = [




          'नमस्ते किसान भाई! आज मैं आपकी कैसे मदद कर सकता हूँ?',




          'आपका स्वागत है! चलिए आज की फसल, मौसम और बाजार पर चर्चा करें।',




          'नमस्ते! आपका Agroksha AI सहायक तैयार है।',




          'किसान भाई का स्वागत है! क्या आपको खेती में कोई मदद चाहिए?',




          'नमस्ते। आपकी फसल और मंडी की जानकारी उपलब्ध है।',




        ];




        return list[rand];




      case AppLanguage.kannada:




        final list = [




          'ನಮಸ್ಕಾರ ರೈತರೆ! ಇಂದು ನಾನು ನಿಮಗೆ ಹೇಗೆ ಸಹಾಯ ಮಾಡಬಹುದು?',




          'ಸ್ವಾಗತ! ಇಂದು ಬೆಳೆ, ಹವಾಮಾನ ಮತ್ತು ಮಾರುಕಟ್ಟೆ ಬಗ್ಗೆ ಮಾತನಾಡೋಣ.',




          'ನಮಸ್ಕಾರ! ನಿಮ್ಮ Agroksha AI ಸಹಾಯಕ ಸಿದ್ಧವಾಗಿದೆ.',




          'ರೈತರಿಗೆ ಸ್ವಾಗತ! ಇಂದು ಕೃಷಿಯಲ್ಲಿ ಯಾವುದೇ ಸಹಾಯ ಬೇಕೇ?',




          'ನಮಸ್ಕಾರ. ನಿಮ್ಮ ಬೆಳೆ ಮತ್ತು ಮಾರುಕಟ್ಟೆ ಮಾಹಿತಿ ಲಭ್ಯವಿದೆ.',




        ];




        return list[rand];




      case AppLanguage.tamil:




        final list = [




          'வணக்கம் விவசாயி! இன்று நான் உங்களுக்கு எப்படி உதவ முடியும்?',




          'வரவேற்கிறோம்! இன்று பயிர், வானிலை மற்றும் சந்தை பற்றி பேசுவோம்.',




          'வணக்கம்! உங்கள் Agroksha AI உதவியாளர் தயார்.',




          'விவசாயிக்கு வரவேற்பு! விவசாயத்தில் ஏதேனும் உதவி வேண்டுமா?',




          'வணக்கம். உங்கள் பயிர் மற்றும் சந்தை தகவல் கிடைக்கிறது.',




        ];




        return list[rand];




      case AppLanguage.english:




      default:




        final list = [




          'Hello farmer! Agroksha AI Assistant is ready to help you today.',




          'Welcome back! Let us check your crop and weather updates together.',




          'Hello! Your farming assistant is ready with today\'s insights.',




          'Good day farmer! How can I assist your farm work today?',




          'Welcome! Agroksha AI is here to support your farming decisions.',




        ];




        return list[rand];




    }




  }














  String buildWeatherGreeting(WeatherModel weather, AppLanguage lang) {




    final rain = weather.rainChance;




    final temp = weather.temperature.toInt();




    final cond = weather.condition.toLowerCase();









    switch (lang) {




      case AppLanguage.telugu:




        if (rain > 70 || cond.contains('rain')) {




          return 'జాగ్రత్త! వర్షం వచ్చే అవకాశం ${rain.toInt()} శాతం ఉంది. ఈరోజు మందుల పిచికారీ చేయవద్దు.';




        } else if (temp > 38) {




          return 'ఈరోజు ఎండ ఎక్కువగా ఉంది. ఉష్ణోగ్రత $temp డిగ్రీలు. పొద్దున లేదా సాయంత్రం నీళ్ళు పెట్టండి.';




        } else {




          return 'ఈరోజు వాతావరణం మంచిగా ఉంది. ఉష్ణోగ్రత $temp డిగ్రీలు. వ్యవసాయ పనులు చేయవచ్చు.';




        }




      case AppLanguage.hindi:




        if (rain > 70 || cond.contains('rain')) {




          return 'सावधान! बारिश की संभावना ${rain.toInt()} प्रतिशत है। आज कीटनाशक का छिड़काव न करें।';




        } else if (temp > 38) {




          return 'आज धूप तेज है। तापमान $temp डिग्री है। सुबह या शाम को पानी दें।';




        } else {




          return 'आज मौसम अच्छा है। तापमान $temp डिग्री है। आप कृषि कार्य कर सकते हैं।';




        }




      case AppLanguage.kannada:




        if (rain > 70 || cond.contains('rain')) {




          return 'ಎಚ್ಚರಿಕೆ! ಮಳೆಯ ಸಾಧ್ಯತೆ ${rain.toInt()} ಶೇಕಡಾ ಇದೆ. ಇಂದು ಕೀಟನಾಶಕ ಸಿಂಪಡಿಸಬೇಡಿ.';




        } else if (temp > 38) {




          return 'ಇಂದು ಬಿಸಿಲು ಹೆಚ್ಚಾಗಿದೆ. ತಾಪಮಾನ $temp ಡಿಗ್ರಿ. ಬೆಳಿಗ್ಗೆ ಅಥವಾ ಸಂಜೆ ನೀರು ಹಾಕಿ.';




        } else {




          return 'ಇಂದು ಹವಾಮಾನ ಉತ್ತಮವಾಗಿದೆ. ತಾಪಮಾನ $temp ಡಿಗ್ರಿ. ಕೃಷಿ ಕೆಲಸಗಳನ್ನು ಮಾಡಬಹುದು.';




        }




      case AppLanguage.tamil:




        if (rain > 70 || cond.contains('rain')) {




          return 'கவனம்! மழை வாய்ப்பு ${rain.toInt()} சதவீதம் உள்ளது. இன்று பூச்சிக்கொல்லி தெளிக்க வேண்டாம்.';




        } else if (temp > 38) {




          return 'இன்று வெயில் அதிகம். வெப்பநிலை $temp டிகிரி. காலை அல்லது மாலையில் தண்ணீர் பாய்ச்சவும்.';




        } else {




          return 'இன்று வானிலை நன்றாக உள்ளது. வெப்பநிலை $temp டிகிரி. விவசாய பணிகளை செய்யலாம்.';




        }




      case AppLanguage.english:




      default:




        if (rain > 70 || cond.contains('rain')) {




          return 'Rain alert! Rain chance is ${rain.toInt()} percent. Avoid pesticide spraying today.';




        } else if (temp > 38) {




          return 'It will be very hot today at $temp degrees Celsius. Irrigate in the early morning or after sunset.';




        } else {




          return 'Weather is good today at $temp degrees. A good day for farm activities.';




        }




    }




  }














  String buildMarketSummary(List<MarketItem> items, AppLanguage lang) {




    if (items.isEmpty) {




      switch (lang) {




        case AppLanguage.telugu: return 'ప్రస్తుతం మార్కెట్ ధరలు అందుబాటులో లేవు.';




        case AppLanguage.hindi: return 'वर्तमान में मंडी की कीमतें उपलब्ध नहीं हैं।';




        case AppLanguage.kannada: return 'ಪ್ರಸ್ತುತ ಮಾರುಕಟ್ಟೆ ಬೆಲೆಗಳು ಲಭ್ಯವಿಲ್ಲ.';




        case AppLanguage.tamil: return 'தற்போது சந்தை விலைகள் கிடைக்கவில்லை.';




        default: return 'Market prices are not available at the moment.';




      }




    }




    final top = items.take(2).toList();




    switch (lang) {




      case AppLanguage.telugu:




        return 'మార్కెట్ ధరలు: ${top.map((m) => "${m.cropName} ₹${m.pricePerQuintal}").join(", ")}.';




      case AppLanguage.hindi:




        return 'मंडी भाव: ${top.map((m) => "${m.cropName} ₹${m.pricePerQuintal}").join(", ")}.';




      case AppLanguage.kannada:




        return 'ಮಾರುಕಟ್ಟೆ ಬೆಲೆ: ${top.map((m) => "${m.cropName} ₹${m.pricePerQuintal}").join(", ")}.';




      case AppLanguage.tamil:




        return 'சந்தை விலை: ${top.map((m) => "${m.cropName} ₹${m.pricePerQuintal}").join(", ")}.';




      default:




        return 'Market: ${top.map((m) => "${m.cropName} at ₹${m.pricePerQuintal} per quintal").join(", ")}.';




    }




  }














  String buildSchemesReminder(String state, AppLanguage lang) {




    switch (lang) {




      case AppLanguage.telugu:




        return state.isNotEmpty ? '$state రాష్ట్ర మరియు కేంద్ర ప్రభుత్వ పథకాలు Schemes విభాగంలో చూడవచ్చు.' : 'ప్రభుత్వ పథకాలు Schemes విభాగంలో చూడవచ్చు.';




      case AppLanguage.hindi:




        return state.isNotEmpty ? '$state राज्य और केंद्र सरकार की योजनाएं Schemes अनुभाग में उपलब्ध हैं।' : 'सरकारी योजनाएं Schemes अनुभाग में उपलब्ध हैं।';




      case AppLanguage.kannada:




        return state.isNotEmpty ? '$state ರಾಜ್ಯ ಮತ್ತು ಕೇಂದ್ರ ಸರ್ಕಾರದ ಯೋಜನೆಗಳು Schemes ವಿಭಾಗದಲ್ಲಿ ಲಭ್ಯವಿದೆ.' : 'ಸರ್ಕಾರಿ ಯೋಜನೆಗಳು Schemes ವಿಭಾಗದಲ್ಲಿ ಲಭ್ಯವಿದೆ.';




      case AppLanguage.tamil:




        return state.isNotEmpty ? '$state மாநில மற்றும் மத்திய அரசு திட்டங்கள் Schemes பிரிவில் உள்ளன.' : 'அரசு திட்டங்கள் Schemes பிரிவில் உள்ளன.';




      default:




        return state.isNotEmpty ? '$state state and central government schemes are available in the Schemes section.' : 'Government schemes are available in the Schemes section.';




    }




  }














  String buildTip(String tip, AppLanguage lang) {




    switch (lang) {




      case AppLanguage.telugu: return 'ఈరోజు చిట్కా: $tip.';




      case AppLanguage.hindi: return 'आज का टिप: $tip.';




      case AppLanguage.kannada: return 'ಇಂದಿನ ಸಲಹೆ: $tip.';




      case AppLanguage.tamil: return 'இன்றைய குறிப்பு: $tip.';




      default: return 'Today\'s tip: $tip.';




    }




  }









}
























