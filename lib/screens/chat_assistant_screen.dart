// ─────────────────────────────────────────────────────────────────────────────
// AGROKSHA AI  Premium Chat Assistant
// Reliable: retry on fail | full responses | copy/speak | no API names
// ─────────────────────────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../utils/app_provider.dart';
import '../services/ai_service.dart';
import '../services/voice_service.dart';
import '../models/models.dart';
// ── Chat message model ─────────────────────────────────────────────────────
class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  bool hasFailed;
  ChatMessage({required this.text, required this.isUser, this.hasFailed = false})
      : timestamp = DateTime.now();
}
// ── Suggested quick questions ──────────────────────────────────────────────
const _suggestedTe = [
  'ఈరోజు పత్తి అమ్మాలా?',
  'రేపు వర్షం వస్తే మందు వేయొచ్చా?',
  'ఈరోజు నీరు పెట్టాలా?',
  'ఎరువు వేయాలా?',
  'ప్రభుత్వ పథకాలు ఏమైనా ఉన్నాయా?',
  'ఈ సీజన్‌లో best crop ఏది?',
];
const _suggestedEn = [
  'Should I sell cotton today?',
  'Can I spray if it rains tomorrow?',
  'Is it a good day to irrigate?',
  'Which fertilizer should I apply?',
  'Any govt schemes for farmers?',
  'Best crop for this season?',
];
const _suggestedHi = [
  'क्या आज कपास बेचना चाहिए?',
  'अगर कल बारिश हो तो क्या कीटनाशक डाल सकते हैं?',
  'क्या आज सिंचाई करनी चाहिए?',
  'कौन सी खाद डालें?',
  'किसानों के लिए कोई सरकारी योजना है?',
  'इस मौसम में सबसे अच्छी फसल कौन सी है?',
];
const _suggestedKn = [
  'ಇಂದು ಹತ್ತಿ ಮಾರಬೇಕೇ?',
  'ನಾಳೆ ಮಳೆ ಬಂದರೆ ಕೀಟನಾಶಕ ಹಾಕಬಹುದೇ?',
  'ಇಂದು ನೀರು ಹಾಕಬೇಕೇ?',
  'ಯಾವ ರಸಗೊಬ್ಬರ ಹಾಕಬೇಕು?',
  'ರೈತರಿಗೆ ಯಾವುದಾದರೂ ಸರ್ಕಾರಿ ಯೋಜನೆ ಇದೆಯೇ?',
  'ಈ ಋತುವಿನಲ್ಲಿ ಯಾವ ಬೆಳೆ ಉತ್ತಮ?',
];
const _suggestedTa = [
  'இன்று பருத்தி விற்கலாமா?',
  'நாளை மழை பெய்தால் பூச்சிக்கொல்லி தெளிக்கலாமா?',
  'இன்று நீர் பாய்ச்சலாமா?',
  'எந்த உரம் போட வேண்டும்?',
  'விவசாயிகளுக்கு ஏதாவது அரசு திட்டம் இருக்கிறதா?',
  'இந்த பருவத்தில் சிறந்த பயிர் எது?',
];
class ChatAssistantScreen extends StatefulWidget {
  final bool autoListen;
  const ChatAssistantScreen({super.key, this.autoListen = false});
  @override
  State<ChatAssistantScreen> createState() => _ChatAssistantScreenState();
}
class _ChatAssistantScreenState extends State<ChatAssistantScreen>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  final List<ChatEntry> _history = [];
  bool _isTyping = false;
  bool _isListening = false;
  bool _showSuggestions = true;
  late AnimationController _micPulse;
  @override
  void initState() {
    super.initState();
    _micPulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addInitialGreeting();
      if (widget.autoListen) {
        Future.delayed(const Duration(milliseconds: 1300), _toggleListening);
      }
    });
  }
  void _addInitialGreeting() {
    final lang = context.read<AppProvider>().language;
    final location = context.read<AppProvider>().farmerLocation;
    final district = location?.district ?? '';
    String greeting = '';
    switch (lang) {
      case AppLanguage.telugu:
        greeting = 'నమస్కారం రైతు బంధూ! 🌾\n${district.isNotEmpty ? "$district జిల్లా రైతుకు " : ""}స్వాగతం.\nఈరోజు వ్యవసాయంలో మీకు ఏవైనా ప్రశ్నలు ఉంటే అడగండి.';
        break;
      case AppLanguage.hindi:
        greeting = 'नमस्ते किसान भाई! 🌾\n${district.isNotEmpty ? "$district जिले के किसान का " : ""}स्वागत है।\nअपने AGROKSHA AI सहायक से खेती से जुड़ा कोई भी सवाल पूछें।';
        break;
      case AppLanguage.kannada:
        greeting = 'ನಮಸ್ಕಾರ ರೈತರೆ! 🌾\n${district.isNotEmpty ? "$district ಜಿಲ್ಲೆಯ ರೈತರಿಗೆ " : ""}ಸ್ವಾಗತ.\nನಾನು ನಿಮ್ಮ AGROKSHA AI ಸಹಾಯಕ. ಯಾವುದೇ ಕೃಷಿ ಪ್ರಶ್ನೆಗಳನ್ನು ಕೇಳಿ.';
        break;
      case AppLanguage.tamil:
        greeting = 'வணக்கம் விவசாயி! 🌾\n${district.isNotEmpty ? "$district மாவட்ட விவசாயிக்கு " : ""}வரவேற்பு.\nநான் உங்கள் AGROKSHA AI உதவியாளர். விவசாயம் தொடர்பான எந்த கேள்வியையும் கேளுங்கள்.';
        break;
      case AppLanguage.english:
      default:
        greeting = 'Namaskaram Farmer! 🌾\n${district.isNotEmpty ? "Welcome, $district farmer. " : "Welcome. "}I am your AGROKSHA AI Assistant.\nFeel free to ask any farming question.';
        break;
    }
    setState(() {
      _messages.add(ChatMessage(text: greeting, isUser: false));
    });
    VoiceService().speak(greeting, language: lang);
  }
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeOut,
        );
      }
    });
  }
  Future<void> _sendMessage(String text, {bool isRetry = false}) async {
    if (text.trim().isEmpty || _isTyping) return;
    final provider = context.read<AppProvider>();
    final trimmed = text.trim();
    if (!isRetry) {
      setState(() {
        _messages.add(ChatMessage(text: trimmed, isUser: true));
        _isTyping = true;
        _showSuggestions = false;
      });
      _textController.clear();
    } else {
      setState(() => _isTyping = true);
    }
    _scrollToBottom();
    final response = await AIService.chat(
      userMessage: trimmed,
      language: provider.language,
      weather: provider.weather,
      location: provider.farmerLocation,
      currentCrop: provider.selectedCrop,
      marketData: provider.allMarketItems,
      history: List.from(_history),
      farmerName: provider.currentUser?.name,
    );
    // Detect if it's an error fallback response
    final hasFailed = response.contains('network') ||
        response.contains('నెట�?‌వర�?క�?') ||
        response.contains('unavailable') ||
        response.contains('అంద�?బాట�?లో లేద�?');
    // Update history for multi-turn context
    _history.add(ChatEntry(role: 'user', content: trimmed));
    _history.add(ChatEntry(role: 'assistant', content: response));
    if (mounted) {
      setState(() {
        _messages.add(ChatMessage(
            text: response, isUser: false, hasFailed: hasFailed));
        _isTyping = false;
      });
      _scrollToBottom();
      if (!hasFailed) {
        VoiceService().speak(response,
            language: provider.language, speed: provider.voiceSpeed);
      }
    }
  }
  void _toggleListening() {
    final voice = VoiceService();
    final provider = context.read<AppProvider>();
    if (_isListening) {
      voice.stopListening();
      _micPulse.stop();
      if (mounted) setState(() => _isListening = false);
    } else {
      if (voice.isPlaying) voice.stop();
      setState(() => _isListening = true);
      _micPulse.repeat(reverse: true);
      voice.startListening(
        language: provider.language,
        onResult: (text) {
          if (text.isNotEmpty) {
            _textController.text = text;
            _sendMessage(text);
          }
          _micPulse.stop();
          if (mounted) setState(() => _isListening = false);
        },
      );
    }
  }
  void _copyMessage(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Message copied'),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
  void _speakMessage(ChatMessage msg) {
    final provider = context.read<AppProvider>();
    VoiceService().speak(msg.text, language: provider.language);
  }
  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _micPulse.dispose();
    VoiceService().stop();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? AppColors.darkBackground : const Color(0xFFF0F4F0),
      appBar: _buildAppBar(provider, isDark),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              itemCount:
                  _messages.length + (_isTyping ? 1 : 0) + (_showSuggestions ? 1 : 0),
              itemBuilder: (context, index) {
                if (_showSuggestions && index == 1) {
                  return _buildSuggestions(provider.language);
                }
                final msgIndex =
                    _showSuggestions && index > 1 ? index - 1 : index;
                if (msgIndex == _messages.length && _isTyping) {
                  return _buildTypingIndicator(isDark);
                }
                if (msgIndex < _messages.length) {
                  return _buildMessageBubble(
                      _messages[msgIndex], isDark, msgIndex);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          _buildInputArea(isDark, provider),
        ],
      ),
    );
  }
  PreferredSizeWidget _buildAppBar(AppProvider provider, bool isDark) {
    return AppBar(
      backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF134D2A), Color(0xFF2E9659)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 8,
                )
              ],
            ),
            child: ClipOval(
              child: Image.asset('assets/images/ai_avatar.png', width: 38, height: 38, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                const Text('AGROKSHA ', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                Container(padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(color: const Color(0xFFE65100), borderRadius: BorderRadius.circular(4)),
                  child: const Text('AI', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w900))),
              ]),
              Text(
                'Assistant  Online',
                style: TextStyle(
                    fontSize: 10,
                    color: AppColors.riskLow,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
      actions: [
        // Language toggle
        GestureDetector(
          onTap: () => provider.setLanguage(
            provider.language == AppLanguage.telugu
                ? AppLanguage.english
                : AppLanguage.telugu,
          ),
          child: Container(
            margin: const EdgeInsets.only(right: 6),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Text(
              provider.language == AppLanguage.telugu ? 'EN' : 'తె',
              style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                  fontSize: 13),
            ),
          ),
        ),
        // Stop speaking
        if (VoiceService().isPlaying)
          IconButton(
            icon: const Icon(Icons.volume_off_rounded, color: AppColors.riskHigh, size: 22),
            onPressed: () {
              VoiceService().stop();
              setState(() {});
            },
          ),
      ],
    );
  }
  Widget _buildSuggestions(AppLanguage language) {
    final chips = language == AppLanguage.telugu ? _suggestedTe : _suggestedEn;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        Text(
          language == AppLanguage.telugu ? '💡 ప�?రాంప�?ట�? ప�?రశ�?నల�?:' : '💡 Suggested questions:',
          style: const TextStyle(
              fontSize: 11, color: AppColors.textLight, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 7,
          runSpacing: 7,
          children: chips
              .map((q) => GestureDetector(
                    onTap: () => _sendMessage(q),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 7),
                      decoration: BoxDecoration(
                        color: AppColors.primarySurface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: AppColors.primary.withOpacity(0.22)),
                      ),
                      child: Text(
                        q,
                        style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 14),
      ],
    ).animate().fadeIn(duration: 400.ms);
  }
  Widget _buildMessageBubble(ChatMessage msg, bool isDark, int idx) {
    final isUser = msg.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () => _showMessageOptions(msg),
        child: Container(
          margin: EdgeInsets.only(
            bottom: 10,
            left: isUser ? 48 : 0,
            right: isUser ? 0 : 48,
          ),
          child: Column(
            crossAxisAlignment:
                isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              // AI label
              if (!isUser)
                Padding(
                  padding: const EdgeInsets.only(left: 6, bottom: 3),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: Image.asset('assets/images/ai_avatar.png', width: 16, height: 16, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text('AGROKSHA AI',
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary)),
                    ],
                  ),
                ),
              // Bubble
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                decoration: BoxDecoration(
                  color: isUser
                      ? AppColors.primary
                      : msg.hasFailed
                          ? Colors.orange.shade50
                          : (isDark ? AppColors.darkSurface : Colors.white),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(18),
                    topRight: const Radius.circular(18),
                    bottomLeft: Radius.circular(isUser ? 18 : 4),
                    bottomRight: Radius.circular(isUser ? 4 : 18),
                  ),
                  border: msg.hasFailed
                      ? Border.all(color: Colors.orange.shade200)
                      : null,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      msg.text,
                      style: TextStyle(
                        color: isUser
                            ? Colors.white
                            : (isDark ? AppColors.darkText : AppColors.textDark),
                        fontSize: 14.5,
                        height: 1.55,
                      ),
                    ),
                    // Retry row for failed messages
                    if (msg.hasFailed) ...[
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          // Find the last user message before this one
                          final userMsgs = _messages
                              .where((m) => m.isUser)
                              .toList();
                          if (userMsgs.isNotEmpty) {
                            _sendMessage(userMsgs.last.text, isRetry: true);
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.refresh_rounded,
                                size: 14, color: Colors.orange),
                            const SizedBox(width: 4),
                            Text(
                              context.read<AppProvider>().language ==
                                      AppLanguage.telugu
                                  ? 'మళ�?ళీ ప�?రయత�?నించ�?'
                                  : 'Tap to retry',
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Timestamp + action row
              Padding(
                padding: const EdgeInsets.only(top: 3, left: 4, right: 4),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _formatTime(msg.timestamp),
                      style: const TextStyle(
                          fontSize: 9, color: AppColors.textLight),
                    ),
                    if (!isUser) ...[
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _speakMessage(msg),
                        child: const Icon(Icons.volume_up_rounded,
                            size: 13, color: AppColors.textLight),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: () => _copyMessage(msg.text),
                        child: const Icon(Icons.copy_rounded,
                            size: 13, color: AppColors.textLight),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.06),
    );
  }
  void _showMessageOptions(ChatMessage msg) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(18))),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.copy_rounded, color: AppColors.primary),
              title: const Text('Copy message'),
              onTap: () {
                Navigator.pop(context);
                _copyMessage(msg.text);
              },
            ),
            if (!msg.isUser)
              ListTile(
                leading: const Icon(Icons.volume_up_rounded, color: AppColors.primary),
                title: const Text('Read aloud'),
                onTap: () {
                  Navigator.pop(context);
                  _speakMessage(msg);
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
  Widget _buildTypingIndicator(bool isDark) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomRight: Radius.circular(18),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dot(0),
            const SizedBox(width: 5),
            _dot(180),
            const SizedBox(width: 5),
            _dot(360),
          ],
        ),
      ),
    );
  }
  Widget _dot(int delay) {
    return Container(
      width: 9,
      height: 9,
      decoration: const BoxDecoration(
          color: AppColors.primary, shape: BoxShape.circle),
    )
        .animate(onPlay: (c) => c.repeat(reverse: true))
        .scale(
            duration: 500.ms,
            delay: delay.ms,
            begin: const Offset(0.5, 0.5),
            end: const Offset(1.2, 1.2));
  }
  Widget _buildInputArea(bool isDark, AppProvider provider) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -3),
          )
        ],
      ),
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Mic with animated pulse
            AnimatedBuilder(
              animation: _micPulse,
              builder: (_, __) {
                final scale =
                    _isListening ? 1.0 + (_micPulse.value * 0.16) : 1.0;
                return Transform.scale(
                  scale: scale,
                  child: GestureDetector(
                    onTap: _toggleListening,
                    child: Container(
                      width: 46,
                      height: 46,
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: _isListening
                            ? Colors.red.withOpacity(0.1)
                            : AppColors.primary.withOpacity(0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _isListening
                              ? Colors.red
                              : AppColors.primary.withOpacity(0.5),
                          width: _isListening ? 2 : 1,
                        ),
                      ),
                      child: Icon(
                        _isListening
                            ? Icons.mic_rounded
                            : Icons.mic_none_rounded,
                        color: _isListening ? Colors.red : AppColors.primary,
                        size: 22,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            // Text input
            Expanded(
              child: Container(
                constraints: const BoxConstraints(maxHeight: 100),
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.darkBackground
                      : const Color(0xFFF0F4F0),
                  borderRadius: BorderRadius.circular(22),
                  border:
                      Border.all(color: AppColors.primary.withOpacity(0.15)),
                ),
                child: TextField(
                  controller: _textController,
                  maxLines: null,
                  textInputAction: TextInputAction.send,
                  decoration: InputDecoration(
                    hintText: provider.t(S.chatHint),
                    hintStyle: const TextStyle(
                        color: AppColors.textLight, fontSize: 13),
                    border: InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 10),
                  ),
                  style: const TextStyle(fontSize: 14.5),
                  onSubmitted: _sendMessage,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Send button
            GestureDetector(
              onTap: () => _sendMessage(_textController.text),
              child: Container(
                width: 46,
                height: 46,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.send_rounded,
                    color: Colors.white, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
