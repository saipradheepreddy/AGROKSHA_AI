/// ─────────────────────────────────────────────────────────────────────────────



/// AGROKSHA AI — Privacy Policy Screen



/// ─────────────────────────────────────────────────────────────────────────────







import 'package:flutter/material.dart';



import 'package:flutter_animate/flutter_animate.dart';



import '../theme/app_theme.dart';







class PrivacyPolicyScreen extends StatelessWidget {



  const PrivacyPolicyScreen({super.key});







  @override



  Widget build(BuildContext context) {



    final isDark = Theme.of(context).brightness == Brightness.dark;







    return Scaffold(



      appBar: AppBar(



        title: const Text('Privacy Policy'),



        centerTitle: true,



        elevation: 0,



      ),



      body: SingleChildScrollView(



        padding: const EdgeInsets.all(24),



        child: Column(



          crossAxisAlignment: CrossAxisAlignment.start,



          children: [



            const Row(



              children: [



                Icon(Icons.shield_rounded, color: AppColors.primary, size: 32),



                SizedBox(width: 12),



                Expanded(



                  child: Text(



                    'Your Data is Protected',



                    style: TextStyle(



                      fontSize: 22,



                      fontWeight: FontWeight.w800,



                      color: AppColors.primary,



                    ),



                  ),



                ),



              ],



            ).animate().fadeIn().slideX(begin: -0.2),



            const SizedBox(height: 24),



            



            _PolicySection(



              title: 'Personal Details Storage',



              icon: Icons.person_rounded,



              content: 'Farmer data and personal details are securely stored locally and via secure session management. We prioritize your privacy above all.',



              delay: 100,



            ),



            const SizedBox(height: 16),



            



            _PolicySection(



              title: 'Location Usage',



              icon: Icons.location_on_rounded,



              content: 'Your location is used strictly for providing accurate, hyper-local weather insights, market prices, and farming suggestions. We do not track you continuously.',



              delay: 200,



            ),



            const SizedBox(height: 16),



            



            _PolicySection(



              title: 'No Data Selling',



              icon: Icons.block_rounded,



              content: 'AGROKSHA AI guarantees that your data is NOT sold to third parties, marketing agencies, or any external entities.',



              delay: 300,



            ),



            const SizedBox(height: 16),



            



            _PolicySection(



              title: 'User Control',



              icon: Icons.settings_rounded,



              content: 'You have full control over your preferences. You can update or delete your profile, location data, and preferences anytime from the Settings menu.',



              delay: 400,



            ),



            const SizedBox(height: 16),



            



            _PolicySection(



              title: 'Secure Login Practices',



              icon: Icons.lock_rounded,



              content: 'We employ industry-standard secure login practices and encrypted session management to ensure your account remains safe from unauthorized access.',



              delay: 500,



            ),



            



            const SizedBox(height: 40),



            Center(



              child: Text(



                'Last updated: April 2026',



                style: TextStyle(



                  fontSize: 12,



                  color: isDark ? Colors.white54 : AppColors.textLight,



                ),



              ),



            ).animate(delay: 600.ms).fadeIn(),



            const SizedBox(height: 20),



          ],



        ),



      ),



    );



  }



}







class _PolicySection extends StatelessWidget {



  final String title;



  final String content;



  final IconData icon;



  final int delay;







  const _PolicySection({



    required this.title,



    required this.content,



    required this.icon,



    required this.delay,



  });







  @override



  Widget build(BuildContext context) {



    final isDark = Theme.of(context).brightness == Brightness.dark;



    



    return Container(



      width: double.infinity,



      padding: const EdgeInsets.all(16),



      decoration: BoxDecoration(



        color: isDark ? AppColors.darkCard : Colors.white,



        borderRadius: BorderRadius.circular(14),



        border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),



        boxShadow: AppTheme.cardShadow,



      ),



      child: Column(



        crossAxisAlignment: CrossAxisAlignment.start,



        children: [



          Row(



            children: [



              Container(



                padding: const EdgeInsets.all(8),



                decoration: BoxDecoration(



                  color: AppColors.primarySurface,



                  borderRadius: BorderRadius.circular(8),



                ),



                child: Icon(icon, color: AppColors.primary, size: 18),



              ),



              const SizedBox(width: 12),



              Expanded(



                child: Text(



                  title,



                  style: TextStyle(



                    fontSize: 15,



                    fontWeight: FontWeight.w700,



                    color: isDark ? Colors.white : AppColors.textDark,



                  ),



                ),



              ),



            ],



          ),



          const SizedBox(height: 10),



          Text(



            content,



            style: TextStyle(



              fontSize: 13,



              height: 1.5,



              color: isDark ? Colors.white70 : AppColors.textMedium,



            ),



          ),



        ],



      ),



    ).animate(delay: delay.ms).fadeIn().slideY(begin: 0.1);



  }



}



