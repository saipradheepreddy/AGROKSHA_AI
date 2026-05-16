/// ─────────────────────────────────────────────────────────────────────────────



/// AGROKSHA AI — Terms & Conditions Screen



/// ─────────────────────────────────────────────────────────────────────────────







import 'package:flutter/material.dart';



import 'package:flutter_animate/flutter_animate.dart';



import '../theme/app_theme.dart';







class TermsScreen extends StatelessWidget {



  const TermsScreen({super.key});







  @override



  Widget build(BuildContext context) {



    final isDark = Theme.of(context).brightness == Brightness.dark;







    return Scaffold(



      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,



      appBar: AppBar(



        title: const Text('Terms & Conditions'),



        centerTitle: true,



        elevation: 0,



        backgroundColor: isDark ? AppColors.darkSurface : Colors.white,



      ),



      body: SingleChildScrollView(



        padding: const EdgeInsets.all(20),



        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



          // Header



          Container(



            padding: const EdgeInsets.all(16),



            decoration: BoxDecoration(



              gradient: const LinearGradient(



                colors: [AppColors.primary, Color(0xFF2E9659)],



                begin: Alignment.topLeft, end: Alignment.bottomRight,



              ),



              borderRadius: BorderRadius.circular(14),



            ),



            child: const Row(children: [



              Icon(Icons.gavel_rounded, color: Colors.white, size: 28),



              SizedBox(width: 12),



              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



                Text('Terms & Conditions', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),



                Text('AGROKSHA AI — TEAM SARA', style: TextStyle(color: Colors.white70, fontSize: 11)),



              ])),



            ]),



          ).animate().fadeIn(duration: 500.ms),



          const SizedBox(height: 20),







          _TermsSection(



            number: '1',



            title: 'Acceptance of Terms',



            content: 'By downloading and using AGROKSHA AI, you agree to be bound by these Terms & Conditions. If you do not agree, please do not use the app.',



            delay: 100,



          ),



          _TermsSection(



            number: '2',



            title: 'Use of the Application',



            content: 'AGROKSHA AI is designed exclusively for Indian farmers to receive agricultural guidance, weather insights, and market information. The app must be used for lawful purposes only.',



            delay: 150,



          ),



          _TermsSection(



            number: '3',



            title: 'AI Advisory Disclaimer',



            content: 'The AI-based advice and recommendations provided are for informational purposes only. AGROKSHA AI does not guarantee crop yields, weather accuracy, or market outcomes. Always consult a certified Agriculture Officer for critical decisions.',



            delay: 200,



          ),



          _TermsSection(



            number: '4',



            title: 'Market Prices',



            content: 'Market prices displayed are fetched from Agmarknet and other government sources. While we strive for accuracy, prices can vary. Always verify before making selling or buying decisions.',



            delay: 250,



          ),



          _TermsSection(



            number: '5',



            title: 'Location & Permissions',



            content: 'The app requests location access to provide hyper-local weather and market data. Microphone access is requested for voice-based interaction. These permissions are optional and can be denied; the app works in manual mode.',



            delay: 300,



          ),



          _TermsSection(



            number: '6',



            title: 'User Accounts',



            content: 'You are responsible for keeping your account credentials secure. AGROKSHA AI shall not be liable for unauthorized access resulting from user negligence.',



            delay: 350,



          ),



          _TermsSection(



            number: '7',



            title: 'Intellectual Property',



            content: 'All content, branding, UI design, and AI systems within AGROKSHA AI are the intellectual property of TEAM SARA. Unauthorized copying or reproduction is prohibited.',



            delay: 400,



          ),



          _TermsSection(



            number: '8',



            title: 'Limitation of Liability',



            content: 'TEAM SARA shall not be liable for any crop loss, financial loss, or damages arising from reliance on app recommendations. Use the app as a supplementary advisory tool only.',



            delay: 450,



          ),



          _TermsSection(



            number: '9',



            title: 'Updates & Modifications',



            content: 'We reserve the right to update these Terms at any time. Continued use of the app after changes constitutes acceptance of the revised Terms.',



            delay: 500,



          ),



          _TermsSection(



            number: '10',



            title: 'Governing Law',



            content: 'These Terms are governed by the laws of India. Any disputes shall be subject to the jurisdiction of courts in India.',



            delay: 550,



          ),



          const SizedBox(height: 24),







          // Contact



          Container(



            padding: const EdgeInsets.all(16),



            decoration: BoxDecoration(



              color: isDark ? AppColors.darkCard : Colors.white,



              borderRadius: BorderRadius.circular(12),



              border: Border.all(color: AppColors.divider),



            ),



            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



              const Text('Contact Us', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: AppColors.primary)),



              const SizedBox(height: 8),



              Text('For questions about these Terms, contact TEAM SARA.',



                style: TextStyle(fontSize: 13, color: isDark ? Colors.white70 : AppColors.textMedium, height: 1.4)),



              const SizedBox(height: 6),



              const Text('Email: support@agroksha.ai',



                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),



            ]),



          ).animate(delay: 600.ms).fadeIn(),



          const SizedBox(height: 16),







          Center(child: Text('Last updated: May 2026 | AGROKSHA AI v2.0',



            style: TextStyle(fontSize: 11, color: isDark ? Colors.white38 : AppColors.textLight)))



              .animate(delay: 700.ms).fadeIn(),



          const SizedBox(height: 30),



        ]),



      ),



    );



  }



}







class _TermsSection extends StatelessWidget {



  final String number, title, content;



  final int delay;



  const _TermsSection({required this.number, required this.title, required this.content, required this.delay});







  @override



  Widget build(BuildContext context) {



    final isDark = Theme.of(context).brightness == Brightness.dark;



    return Padding(



      padding: const EdgeInsets.only(bottom: 12),



      child: Container(



        padding: const EdgeInsets.all(14),



        decoration: BoxDecoration(



          color: isDark ? AppColors.darkCard : Colors.white,



          borderRadius: BorderRadius.circular(12),



          border: Border.all(color: AppColors.divider.withValues(alpha: 0.6)),



          boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],



        ),



        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [



          Container(



            width: 28, height: 28,



            decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),



            child: Center(child: Text(number, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800))),



          ),



          const SizedBox(width: 12),



          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



            Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: isDark ? Colors.white : AppColors.textDark)),



            const SizedBox(height: 6),



            Text(content, style: TextStyle(fontSize: 12, height: 1.5, color: isDark ? Colors.white60 : AppColors.textMedium)),



          ])),



        ]),



      ).animate(delay: delay.ms).fadeIn().slideY(begin: 0.08),



    );



  }



}



