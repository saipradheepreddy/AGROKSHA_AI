/// ─────────────────────────────────────────────────────────────────────────────



/// AGROKSHA AI — Technology Partners Screen



/// Technical info kept here. No API names shown in main app.



/// ─────────────────────────────────────────────────────────────────────────────







import 'package:flutter/material.dart';



import 'package:flutter_animate/flutter_animate.dart';



import '../theme/app_theme.dart';







class TechPartnersScreen extends StatelessWidget {



  const TechPartnersScreen({super.key});







  @override



  Widget build(BuildContext context) {



    final isDark = Theme.of(context).brightness == Brightness.dark;







    return Scaffold(



      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,



      appBar: AppBar(



        title: const Text('Technology'),



        centerTitle: true,



        elevation: 0,



        backgroundColor: isDark ? AppColors.darkSurface : Colors.white,



      ),



      body: SingleChildScrollView(



        padding: const EdgeInsets.all(20),



        child: Column(children: [



          // Header



          Container(



            width: double.infinity,



            padding: const EdgeInsets.all(20),



            decoration: BoxDecoration(



              gradient: const LinearGradient(



                colors: [Color(0xFF050E07), Color(0xFF0A1F10), Color(0xFF0F2E17)],



                begin: Alignment.topLeft, end: Alignment.bottomRight,



              ),



              borderRadius: BorderRadius.circular(16),



            ),



            child: Column(children: [



              const Icon(Icons.hub_rounded, color: Color(0xFFE65100), size: 36),



              const SizedBox(height: 10),



              const Text('Powered By', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900, letterSpacing: 1)),



              const SizedBox(height: 4),



              Text('Technologies that power AGROKSHA AI',



                style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 12)),



            ]),



          ).animate().fadeIn(),



          const SizedBox(height: 20),







          _TechCard(



            icon: Icons.psychology_rounded,



            iconColor: const Color(0xFFE65100),



            title: 'AI Intelligence Engine',



            subtitle: 'Groq Cloud — LLaMA 3.1',



            detail: 'Fast, reliable AI inference using Meta\'s LLaMA 3.1 8B model via Groq\'s ultra-low latency cloud infrastructure. Provides farming advice, market analysis, and crop recommendations.',



            delay: 100,



          ),



          _TechCard(



            icon: Icons.cloud_rounded,



            iconColor: const Color(0xFF1565C0),



            title: 'Weather Intelligence',



            subtitle: 'Open-Meteo API',



            detail: 'Free, open-source weather API providing real-time and 7-day forecast data with 1km resolution. No API key required. Covers all Indian districts.',



            delay: 150,



          ),



          _TechCard(



            icon: Icons.storefront_rounded,



            iconColor: AppColors.primary,



            title: 'Agricultural Market Data',



            subtitle: 'Agmarknet / Data.gov.in',



            detail: 'India\'s official agricultural marketing information network providing daily APMC market prices and MSP data from Government of India.',



            delay: 200,



          ),



          _TechCard(



            icon: Icons.map_rounded,



            iconColor: const Color(0xFF006064),



            title: 'Maps & Location',



            subtitle: 'OpenStreetMap + Overpass API',



            detail: 'Open-source mapping data for locating nearby mandis, cold storages, and fertilizer shops. No proprietary map costs.',



            delay: 250,



          ),



          _TechCard(



            icon: Icons.smartphone_rounded,



            iconColor: const Color(0xFF4A148C),



            title: 'App Framework',



            subtitle: 'Flutter SDK — Google',



            detail: 'Built with Flutter for cross-platform performance. Single codebase delivers native-quality experience on Android devices.',



            delay: 300,



          ),



          _TechCard(



            icon: Icons.qr_code_rounded,



            iconColor: AppColors.primary,



            title: 'Digital Farm ID',



            subtitle: 'QR Flutter Library',



            detail: 'QR code generation for farmer digital identity cards, enabling easy sharing and verification of farmer profiles.',



            delay: 350,



          ),



          _TechCard(



            icon: Icons.language_rounded,



            iconColor: const Color(0xFFE65100),



            title: 'Localization',



            subtitle: 'Flutter i18n + Custom Maps',



            detail: 'Custom translation system supporting English, Telugu, Hindi, Kannada, and Tamil — covering 500M+ Indian farmers.',



            delay: 400,



          ),



          const SizedBox(height: 20),







          Container(



            padding: const EdgeInsets.all(14),



            decoration: BoxDecoration(



              color: isDark ? AppColors.darkCard : Colors.white,



              borderRadius: BorderRadius.circular(12),



              border: Border.all(color: AppColors.divider),



            ),



            child: Row(children: [



              const Icon(Icons.info_outline_rounded, color: AppColors.textLight, size: 18),



              const SizedBox(width: 10),



              Expanded(child: Text(



                'AGROKSHA AI uses open-source and government APIs to keep the app free for all farmers. No farmer data is shared with any of these services.',



                style: TextStyle(fontSize: 11, color: isDark ? Colors.white60 : AppColors.textLight, height: 1.4),



              )),



            ]),



          ).animate(delay: 450.ms).fadeIn(),



          const SizedBox(height: 30),



        ]),



      ),



    );



  }



}







class _TechCard extends StatelessWidget {



  final IconData icon;



  final Color iconColor;



  final String title, subtitle, detail;



  final int delay;



  const _TechCard({required this.icon, required this.iconColor, required this.title, required this.subtitle, required this.detail, required this.delay});







  @override



  Widget build(BuildContext context) {



    final isDark = Theme.of(context).brightness == Brightness.dark;



    return Padding(



      padding: const EdgeInsets.only(bottom: 12),



      child: Container(



        padding: const EdgeInsets.all(14),



        decoration: BoxDecoration(



          color: isDark ? AppColors.darkCard : Colors.white,



          borderRadius: BorderRadius.circular(14),



          border: Border.all(color: AppColors.divider.withValues(alpha: 0.5)),



          boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 3))],



        ),



        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [



          Container(



            padding: const EdgeInsets.all(10),



            decoration: BoxDecoration(color: iconColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),



            child: Icon(icon, color: iconColor, size: 22),



          ),



          const SizedBox(width: 12),



          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [



            Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: isDark ? Colors.white : AppColors.textDark)),



            const SizedBox(height: 2),



            Text(subtitle, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),



            const SizedBox(height: 6),



            Text(detail, style: TextStyle(fontSize: 12, height: 1.4, color: isDark ? Colors.white60 : AppColors.textMedium)),



          ])),



        ]),



      ).animate(delay: delay.ms).fadeIn().slideX(begin: 0.05),



    );



  }



}



