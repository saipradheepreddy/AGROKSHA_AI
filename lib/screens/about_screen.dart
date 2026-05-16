/// ─────────────────────────────────────────────────────────────────────────────




/// AGROKSHA AI — About Screen




/// Smart Farming. Intelligent Future. | TEAM SARA




/// ─────────────────────────────────────────────────────────────────────────────









import 'package:flutter/material.dart';




import 'package:flutter_animate/flutter_animate.dart';




import '../theme/app_theme.dart';




import 'package:provider/provider.dart';




import '../utils/app_provider.dart';




import '../data/translations.dart';




import 'terms_screen.dart';




import 'tech_partners_screen.dart';




import 'privacy_policy_screen.dart';









class AboutScreen extends StatelessWidget {




  const AboutScreen({super.key});









  @override




  









  // Localized Strings




  String _t(AppLanguage lang, String key) {




    Map<String, Map<AppLanguage, String>> translations = {




      'title': {




        AppLanguage.english: 'About AGROKSHA AI',




        AppLanguage.telugu: 'AGROKSHA AI గురించి',




        AppLanguage.hindi: 'AGROKSHA AI के बारे में',




        AppLanguage.kannada: 'AGROKSHA AI ಬಗ್ಗೆ',




        AppLanguage.tamil: 'AGROKSHA AI பற்றி',




      },




      'content': {




        AppLanguage.english: 'AGROKSHA AI is an intelligent farming assistant built specifically for Indian farmers. It provides real-time weather insights, AI-powered crop disease detection, live market prices, government scheme alerts, and smart crop recommendations — all in your local language.\n\nOur mission: Empower every farmer with AI-grade intelligence at zero cost.',




        AppLanguage.telugu: 'AGROKSHA AI అనేది భారతీయ రైతుల కోసం ప్రత్యేకంగా రూపొందించబడిన స్మార్ట్ వ్యవసాయ సహాయకుడు. ఇది వాతావరణం, AI పంట వ్యాధుల గుర్తింపు, మార్కెట్ ధరలు మరియు పథకాలను మీ సొంత భాషలో అందిస్తుంది.\n\nమా లక్ష్యం: ప్రతి రైతుకు ఉచితంగా AI సాంకేతికతను అందించడం.',




        AppLanguage.hindi: 'AGROKSHA AI भारतीय किसानों के लिए बनाया गया एक स्मार्ट कृषि सहायक है। यह मौसम, फसल रोग पहचान, मंडी भाव और सरकारी योजनाओं की जानकारी आपकी भाषा में देता है।\n\nहमारा मिशन: हर किसान को मुफ्त में AI तकनीक प्रदान करना।',




        AppLanguage.kannada: 'AGROKSHA AI ಭಾರತೀಯ ರೈತರಿಗಾಗಿ ವಿನ್ಯಾಸಗೊಳಿಸಲಾದ ಸ್ಮಾರ್ಟ್ ಕೃಷಿ ಸಹಾಯಕವಾಗಿದೆ. ಹವಾಮಾನ, ಬೆಳೆ ರೋಗ ಪತ್ತೆ, ಮಾರುಕಟ್ಟೆ ಬೆಲೆ ಮತ್ತು ಯೋಜನೆಗಳನ್ನು ನಿಮ್ಮ ಭಾಷೆಯಲ್ಲಿ ನೀಡುತ್ತದೆ.\n\nನಮ್ಮ ಗುರಿ: ಪ್ರತಿ ರೈತರಿಗೆ ಉಚಿತವಾಗಿ AI ತಂತ್ರಜ್ಞಾನ ಒದಗಿಸುವುದು.',




        AppLanguage.tamil: 'AGROKSHA AI என்பது விவசாயிகளுக்கான ஒரு ஸ்மார்ட் விவசாய உதவியாளர். வானிலை, பயிர் நோய் கண்டறிதல், சந்தை விலை மற்றும் திட்டங்களை உங்கள் மொழியில் வழங்குகிறது.\n\nஎங்கள் நோக்கம்: விவசாயிகளுக்கு இலவசமாக AI தொழில்நுட்பத்தை வழங்குவது.',




      },




      'keyFeatures': {




        AppLanguage.english: 'Key Features',




        AppLanguage.telugu: 'ముఖ్య లక్షణాలు',




        AppLanguage.hindi: 'मुख्य विशेषताएं',




        AppLanguage.kannada: 'ಪ್ರಮುಖ ಲಕ್ಷಣಗಳು',




        AppLanguage.tamil: 'முக்கிய அம்சங்கள்',




      },




      'featuresContent': {




        AppLanguage.english: '🌦️ Real-time weather + 7-day rain forecast\n🤖 AI disease diagnosis from leaf photos\n📊 Live APMC & MSP 2026 market prices\n🗺️ Nearby mandis, cold storage & fertilizer shops\n🌾 Smart crop recommendations by season\n🪪 Digital Farm ID with shareable QR card\n🏛️ e-NAM portal integration\n📡 Offline mode with static disease knowledge base\n🌐 5 languages: English, Telugu, Hindi, ಕನ್ನಡ, தமிழ்',




        AppLanguage.telugu: '🌦️ వాతావరణం + 7-రోజుల వర్ష సూచన\n🤖 AI ఆకు వ్యాధి గుర్తింపు\n📊 లైవ్ APMC & MSP 2026 ధరలు\n🗺️ దగ్గరలోని మండీలు, కోల్డ్ స్టోరేజ్ & ఎరువుల దుకాణాలు\n🌾 స్మార్ట్ పంట సూచనలు\n🪪 డిజిటల్ ఫార్మ్ ID QR తో\n🏛️ e-NAM పోర్టల్ అనుసంధానం\n📡 ఆఫ్‌లైన్ వ్యాధుల సమాచారం\n🌐 5 భాషలు మద్దతు',




        AppLanguage.hindi: '🌦️ मौसम + 7-दिन की बारिश का पूर्वानुमान\n🤖 AI द्वारा फसल रोग की पहचान\n📊 लाइव APMC और MSP 2026 कीमतें\n🗺️ पास की मंडियां और खाद की दुकानें\n🌾 स्मार्ट फसल सिफारिशें\n🪪 डिजिटल फार्म ID QR के साथ\n🏛️ e-NAM पोर्टल एकीकरण\n📡 ऑफ़लाइन मोड ज्ञानकोष\n🌐 5 भाषाओं का समर्थन',




        AppLanguage.kannada: '🌦️ ಹವಾಮಾನ + 7-ದಿನದ ಮಳೆ ಮುನ್ಸೂಚನೆ\n🤖 AI ಬೆಳೆ ರೋಗ ಪತ್ತೆ\n📊 ಲೈವ್ APMC ಮತ್ತು MSP 2026 ಬೆಲೆಗಳು\n🗺️ ಹತ್ತಿರದ ಮಂಡಿಗಳು ಮತ್ತು ರಸಗೊಬ್ಬರ ಅಂಗಡಿಗಳು\n🌾 ಸ್ಮಾರ್ಟ್ ಬೆಳೆ ಶಿಫಾರಸುಗಳು\n🪪 ಡಿಜಿಟಲ್ ಫಾರ್ಮ್ ID QR ನೊಂದಿಗೆ\n🏛️ e-NAM ಪೋರ್ಟಲ್ ಏಕೀಕರಣ\n📡 ಆಫ್‌ಲೈನ್ ಮಾಹಿತಿ\n🌐 5 ಭಾಷೆಗಳ ಬೆಂಬಲ',




        AppLanguage.tamil: '🌦️ வானிலை + 7 நாள் மழை முன்னறிவிப்பு\n🤖 AI பயிர் நோய் கண்டறிதல்\n📊 நேரடி APMC மற்றும் MSP 2026 விலைகள்\n🗺️ அருகிலுள்ள மண்டிகள் மற்றும் உர கடைகள்\n🌾 ஸ்மார்ட் பயிர் பரிந்துரைகள்\n🪪 QR உடன் டிஜிட்டல் பண்ணை ID\n🏛️ e-NAM போர்ட்டல் ஒருங்கிணைப்பு\n📡 ஆஃப்லைன் தகவல்\n🌐 5 மொழிகள் ஆதரவு',




      },




      'team': {




        AppLanguage.english: 'TEAM SARA',




        AppLanguage.telugu: 'టీమ్ సారా',




        AppLanguage.hindi: 'टीम सारा',




        AppLanguage.kannada: 'ಟೀಮ್ ಸಾರಾ',




        AppLanguage.tamil: 'குழு சாரா',




      },




      'teamContent': {




        AppLanguage.english: 'AGROKSHA AI is proudly developed by TEAM SARA — a group of passionate engineers building smart technology for real-world agricultural challenges.\n\nWe are dedicated to making precision farming accessible to every farmer in India, from the smallest village to the largest farm.',




        AppLanguage.telugu: 'AGROKSHA AI ని గర్వంగా TEAM SARA అభివృద్ధి చేసింది. నిజమైన వ్యవసాయ సవాళ్లను పరిష్కరించడానికి మేము స్మార్ట్ టెక్నాలజీని నిర్మిస్తున్నాము.\n\nభారతదేశంలోని ప్రతి రైతుకు కచ్చితమైన వ్యవసాయాన్ని అందుబాటులోకి తీసుకురావడానికి మేము కట్టుబడి ఉన్నాము.',




        AppLanguage.hindi: 'AGROKSHA AI को गर्व से TEAM SARA द्वारा विकसित किया गया है। हम वास्तविक कृषि चुनौतियों के लिए स्मार्ट तकनीक बना रहे हैं।\n\nहम भारत के हर किसान तक सटीक खेती को सुलभ बनाने के लिए समर्पित हैं।',




        AppLanguage.kannada: 'AGROKSHA AI ಅನ್ನು TEAM SARA ಹೆಮ್ಮೆಯಿಂದ ಅಭಿವೃದ್ಧಿಪಡಿಸಿದೆ. ನಾವು ನೈಜ ಕೃಷಿ ಸವಾಲುಗಳಿಗಾಗಿ ಸ್ಮಾರ್ಟ್ ತಂತ್ರಜ್ಞಾನವನ್ನು ನಿರ್ಮಿಸುತ್ತಿದ್ದೇವೆ.\n\nಭಾರತದ ಪ್ರತಿಯೊಬ್ಬ ರೈತರಿಗೂ ನಿಖರವಾದ ಕೃಷಿಯನ್ನು ಲಭ್ಯವಾಗಿಸುವಂತೆ ಮಾಡಲು ನಾವು ಸಮರ್ಪಿತರಾಗಿದ್ದೇವೆ.',




        AppLanguage.tamil: 'AGROKSHA AI பெருமையுடன் TEAM SARA ஆல் உருவாக்கப்பட்டது. உண்மையான விவசாய சவால்களுக்கு ஸ்மார்ட் தொழில்நுட்பத்தை உருவாக்குகிறோம்.\n\nஇந்தியாவின் ஒவ்வொரு விவசாயிக்கும் துல்லியமான விவசாயத்தை அணுகக்கூடியதாக மாற்றுவதற்கு நாங்கள் அர்ப்பணித்துள்ளோம்.',




      },




      'madeWithLove': {




        AppLanguage.english: 'Made with 💚 for Indian Farmers',




        AppLanguage.telugu: 'భారతీయ రైతుల కోసం 💚 తో చేయబడింది',




        AppLanguage.hindi: 'भारतीय किसानों के लिए 💚 से निर्मित',




        AppLanguage.kannada: 'ಭಾರತೀಯ ರೈತರಿಗಾಗಿ 💚 ದಿಂದ ಮಾಡಲಾಗಿದೆ',




        AppLanguage.tamil: 'இந்திய விவசாயிகளுக்காக 💚 உடன் உருவாக்கப்பட்டது',




      },




      'privacy': {




        AppLanguage.english: 'Privacy Policy',




        AppLanguage.telugu: 'గోప్యతా విధానం',




        AppLanguage.hindi: 'गोपनीयता नीति',




        AppLanguage.kannada: 'ಗೌಪ್ಯತೆ ನೀತಿ',




        AppLanguage.tamil: 'தனியுரிமை கொள்கை',




      },




      'terms': {




        AppLanguage.english: 'Terms & Conditions',




        AppLanguage.telugu: 'నియమాలు & షరతులు',




        AppLanguage.hindi: 'नियम और शर्तें',




        AppLanguage.kannada: 'ನಿಯಮಗಳು ಮತ್ತು ಷರತ್ತುಗಳು',




        AppLanguage.tamil: 'விதிமுறைகள் மற்றும் நிபந்தனைகள்',




      },




      'techPartners': {




        AppLanguage.english: 'Technology Partners',




        AppLanguage.telugu: 'సాంకేతిక భాగస్వాములు',




        AppLanguage.hindi: 'प्रौद्योगिकी भागीदार',




        AppLanguage.kannada: 'ತಂತ್ರಜ್ಞಾನ ಪಾಲುದಾರರು',




        AppLanguage.tamil: 'தொழில்நுட்ப கூட்டாளர்கள்',




      },




      'techSubtitle': {




        AppLanguage.english: 'APIs & frameworks powering AGROKSHA AI',




        AppLanguage.telugu: 'AGROKSHA AI ని నడిపించే APIs & ఫ్రేమ్‌వర్క్స్',




        AppLanguage.hindi: 'AGROKSHA AI को शक्ति देने वाले API',




        AppLanguage.kannada: 'AGROKSHA AI ಅನ್ನು ಶಕ್ತಗೊಳಿಸುವ API ಗಳು',




        AppLanguage.tamil: 'AGROKSHA AI ஐ இயக்கும் APIகள்',




      },




    };




    return translations[key]?[lang] ?? translations[key]?[AppLanguage.english] ?? '';




  }




Widget build(BuildContext context) {




    final lang = context.watch<AppProvider>().language;




    final isDark = Theme.of(context).brightness == Brightness.dark;









    return Scaffold(




      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,




      body: CustomScrollView(




        slivers: [




          // Premium gradient app bar




          SliverAppBar(




            expandedHeight: 220,




            pinned: true,




            backgroundColor: AppColors.darkBackground,




            foregroundColor: Colors.white,




            flexibleSpace: FlexibleSpaceBar(




              background: Container(




                decoration: const BoxDecoration(




                  gradient: LinearGradient(




                    colors: [Color(0xFF050E07), Color(0xFF0A1F10), Color(0xFF0F2E17)],




                    begin: Alignment.topCenter,




                    end: Alignment.bottomCenter,




                  ),




                ),




                child: SafeArea(




                  child: Column(




                    mainAxisAlignment: MainAxisAlignment.center,




                    children: [




                      const SizedBox(height: 20),




                      // Logo




                      Container(




                        width: 90,




                        height: 90,




                        decoration: BoxDecoration(




                          color: Colors.black,




                          borderRadius: BorderRadius.circular(20),




                          border: Border.all(color: const Color(0xFFE65100).withValues(alpha: 0.5), width: 1.5),




                          boxShadow: [




                            BoxShadow(color: AppColors.primary.withValues(alpha: 0.4), blurRadius: 20),




                            BoxShadow(color: const Color(0xFFE65100).withValues(alpha: 0.2), blurRadius: 30),




                          ],




                        ),




                        child: ClipRRect(




                          borderRadius: BorderRadius.circular(18),




                          child: Image.asset('assets/images/agroksha_logo.png', fit: BoxFit.cover,




                            errorBuilder: (_, __, ___) => const Icon(Icons.agriculture_rounded, size: 48, color: AppColors.primary)),




                        ),




                      ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),




                      const SizedBox(height: 14),




                      RichText(




                        text: const TextSpan(children: [




                          TextSpan(text: 'AGROKSHA ', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 2)),




                          TextSpan(text: 'AI', style: TextStyle(color: Color(0xFFE65100), fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: 2)),




                        ]),




                      ).animate(delay: 200.ms).fadeIn(),




                      const SizedBox(height: 4),




                      const Text('Smart Farming. Intelligent Future.',




                          style: TextStyle(color: Colors.white54, fontSize: 12, letterSpacing: 0.5))




                          .animate(delay: 300.ms).fadeIn(),




                    ],




                  ),




                ),




              ),




            ),




          ),









          SliverPadding(




            padding: const EdgeInsets.all(20),




            sliver: SliverList(delegate: SliverChildListDelegate([




              const SizedBox(height: 8),









              // Version badge




              Center(child: Container(




                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),




                decoration: BoxDecoration(




                  gradient: const LinearGradient(colors: [AppColors.primary, Color(0xFF2E9659)]),




                  borderRadius: BorderRadius.circular(50),




                ),




                child: const Text('v 2.0.0 — Production Ready',




                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5)),




              )).animate(delay: 300.ms).fadeIn(),




              const SizedBox(height: 24),









              // About App




              _SectionCard(




                icon: Icons.auto_awesome_rounded,




                iconColor: const Color(0xFFE65100),




                title: _t(lang, 'title'),




                content: _t(lang, 'content'),




              ).animate(delay: 400.ms).fadeIn().slideX(begin: -0.05),




              const SizedBox(height: 16),









              // Features




              _SectionCard(




                icon: Icons.rocket_launch_rounded,




                iconColor: AppColors.primary,




                title: _t(lang, 'keyFeatures'),




                content: _t(lang, 'featuresContent'),




              ).animate(delay: 500.ms).fadeIn().slideX(begin: 0.05),




              const SizedBox(height: 16),









              // Team




              _SectionCard(




                icon: Icons.groups_rounded,




                iconColor: const Color(0xFFE65100),




                title: _t(lang, 'team'),




                content: _t(lang, 'teamContent'),




              ).animate(delay: 600.ms).fadeIn().slideX(begin: -0.05),




              const SizedBox(height: 24),









              // Tech stack badges




              Center(child: Wrap(spacing: 8, runSpacing: 8, alignment: WrapAlignment.center, children: [




                for (final t in ['Flutter', 'AI Assistant', 'Open-Meteo', 'Agmarknet', 'e-NAM', 'Supabase'])




                  Container(




                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),




                    decoration: BoxDecoration(




                      color: isDark ? AppColors.darkCard : Colors.white,




                      borderRadius: BorderRadius.circular(20),




                      border: Border.all(color: AppColors.divider),




                    ),




                    child: Text(t, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.primary)),




                  ),




              ])).animate(delay: 700.ms).fadeIn(),




              const SizedBox(height: 32),









              // Copyright




              Center(child: Column(children: [




                Text(_t(lang, 'madeWithLove'),




                    style: TextStyle(fontSize: 12, color: AppColors.textLight, fontWeight: FontWeight.w600)),




                const SizedBox(height: 4),




              Text('© 2026 TEAM SARA • AGROKSHA AI',




                  style: TextStyle(fontSize: 11, color: AppColors.textLight.withValues(alpha: 0.7))),




            ])).animate(delay: 800.ms).fadeIn(),









            const SizedBox(height: 24),









            // ── Legal & Tech Links ──




            Container(




              decoration: BoxDecoration(




                color: isDark ? AppColors.darkCard : Colors.white,




                borderRadius: BorderRadius.circular(14),




                border: Border.all(color: AppColors.divider),




              ),




              child: Column(children: [




                _LegalTile(




                  icon: Icons.shield_rounded, color: AppColors.primary,




                  title: _t(lang, 'privacy'),




                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPolicyScreen())),




                ),




                Divider(height: 1, color: AppColors.divider),




                _LegalTile(




                  icon: Icons.gavel_rounded, color: const Color(0xFFE65100),




                  title: _t(lang, 'terms'),




                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TermsScreen())),




                ),




                Divider(height: 1, color: AppColors.divider),




                _LegalTile(




                  icon: Icons.hub_rounded, color: const Color(0xFF1565C0),




                  title: _t(lang, 'techPartners'),




                  subtitle: _t(lang, 'techSubtitle'),




                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TechPartnersScreen())),




                ),




              ]),




            ).animate(delay: 900.ms).fadeIn(),




            const SizedBox(height: 40),




            ])),




          ),




        ],




      ),




    );




  }




}









class _SectionCard extends StatelessWidget {




  final String title, content;




  final IconData icon;




  final Color iconColor;




  const _SectionCard({required this.title, required this.content, required this.icon, required this.iconColor});









  @override




  Widget build(BuildContext context) {




    final isDark = Theme.of(context).brightness == Brightness.dark;




    return Container(




      width: double.infinity,




      padding: const EdgeInsets.all(18),




      decoration: BoxDecoration(




        color: isDark ? AppColors.darkCard : Colors.white,




        borderRadius: BorderRadius.circular(16),




        boxShadow: AppTheme.cardShadow,




        border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),




      ),




      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [




        Row(children: [




          Container(




            padding: const EdgeInsets.all(8),




            decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),




            child: Icon(icon, color: iconColor, size: 20),




          ),




          const SizedBox(width: 10),




          Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: isDark ? Colors.white : AppColors.textDark)),




        ]),




        const SizedBox(height: 12),




        Text(content, style: TextStyle(fontSize: 13, height: 1.6, color: isDark ? Colors.white70 : AppColors.textMedium)),




      ]),




    );




  }




}









class _LegalTile extends StatelessWidget {




  final IconData icon;




  final Color color;




  final String title;




  final String? subtitle;




  final VoidCallback onTap;




  const _LegalTile({required this.icon, required this.color, required this.title, this.subtitle, required this.onTap});









  @override




  Widget build(BuildContext context) {




    final isDark = Theme.of(context).brightness == Brightness.dark;




    return ListTile(




      leading: Container(




        padding: const EdgeInsets.all(8),




        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),




        child: Icon(icon, color: color, size: 18),




      ),




      title: Text(title, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: isDark ? Colors.white : AppColors.textDark)),




      subtitle: subtitle != null ? Text(subtitle!, style: const TextStyle(fontSize: 11, color: AppColors.textLight)) : null,




      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 12, color: isDark ? Colors.white38 : AppColors.textLight),




      onTap: onTap,




      dense: true,




      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),




    );




  }




}




