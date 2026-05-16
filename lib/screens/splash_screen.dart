/// ─────────────────────────────────────────────────────────────────────────────



/// AGROKSHA AI — Premium Splash Screen



/// Smart Farming. Intelligent Future. | TEAM SARA



/// ─────────────────────────────────────────────────────────────────────────────







import 'dart:math' as math;



import 'package:flutter/material.dart';



import 'package:flutter_animate/flutter_animate.dart';



import 'package:provider/provider.dart';



import '../theme/app_theme.dart';



import '../utils/app_provider.dart';



import 'login_screen.dart';



import 'location_setup_screen.dart';



import 'home_screen.dart';
import 'basic_details_screen.dart';







class SplashScreen extends StatefulWidget {



  const SplashScreen({super.key});



  @override



  State<SplashScreen> createState() => _SplashScreenState();



}







class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {



  late AnimationController _pulseCtrl;



  late AnimationController _rotCtrl;







  @override



  void initState() {



    super.initState();



    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);



    _rotCtrl   = AnimationController(vsync: this, duration: const Duration(seconds: 8))..repeat();



    _initialize();



  }







  @override



  void dispose() {



    _pulseCtrl.dispose();



    _rotCtrl.dispose();



    super.dispose();



  }







  Future<void> _initialize() async {



    final provider = context.read<AppProvider>();



    await provider.initialize();



    await Future.delayed(const Duration(milliseconds: 1800));



    if (!mounted) return;







    Widget next;



    if (!provider.isLoggedIn) {



      next = const LoginScreen();



    } else if (!provider.hasLocation) {



      next = const LocationSetupScreen(isFirstLaunch: true);



    } else {



      next = HomeScreen();



    }







    Navigator.of(context).pushReplacement(



      PageRouteBuilder(



        pageBuilder: (_, __, ___) => next,



        transitionDuration: const Duration(milliseconds: 700),



        transitionsBuilder: (_, animation, __, child) => FadeTransition(



          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),



          child: child,



        ),



      ),



    );



  }







  @override



  Widget build(BuildContext context) {



    final size = MediaQuery.of(context).size;







    return Scaffold(



      backgroundColor: Colors.black,



      body: Stack(



        children: [



          // ── Dark radial background gradient ──────────────────────────────



          Positioned.fill(



            child: Container(



              decoration: const BoxDecoration(



                gradient: RadialGradient(



                  center: Alignment(0, -0.2),



                  radius: 1.0,



                  colors: [



                    Color(0xFF0D2318),



                    Color(0xFF071510),



                    Colors.black,



                  ],



                ),



              ),



            ),



          ),







          // ── Rotating glow ring (behind logo) ─────────────────────────────



          Center(



            child: AnimatedBuilder(



              animation: _rotCtrl,



              builder: (_, __) => Transform.rotate(



                angle: _rotCtrl.value * 2 * math.pi,



                child: Container(



                  width: 200,



                  height: 200,



                  decoration: BoxDecoration(



                    shape: BoxShape.circle,



                    gradient: SweepGradient(



                      colors: [



                        Colors.transparent,



                        AppColors.primary.withValues(alpha: 0.12),



                        const Color(0xFFE65100).withValues(alpha: 0.08),



                        Colors.transparent,



                      ],



                    ),



                  ),



                ),



              ),



            ),



          ),







          // ── Pulsing outer glow ────────────────────────────────────────────



          Center(



            child: AnimatedBuilder(



              animation: _pulseCtrl,



              builder: (_, __) => Container(



                width: 160 + _pulseCtrl.value * 40,



                height: 160 + _pulseCtrl.value * 40,



                decoration: BoxDecoration(



                  shape: BoxShape.circle,



                  color: AppColors.primary.withValues(alpha: 0.04 * (1 - _pulseCtrl.value)),



                ),



              ),



            ),



          ),







          // ── Grid lines (tech feel) ────────────────────────────────────────



          Positioned.fill(



            child: CustomPaint(painter: _GridPainter()),



          ),







          // ── Main content ──────────────────────────────────────────────────



          Center(



            child: Column(



              mainAxisAlignment: MainAxisAlignment.center,



              children: [



                // Logo container



                Container(



                  width: 130,



                  height: 130,



                  decoration: BoxDecoration(



                    color: Colors.black,



                    borderRadius: BorderRadius.circular(30),



                    border: Border.all(color: const Color(0xFFE65100).withValues(alpha: 0.4), width: 1.5),



                    boxShadow: [



                      BoxShadow(color: AppColors.primary.withValues(alpha: 0.35), blurRadius: 40, spreadRadius: 0),



                      BoxShadow(color: const Color(0xFFE65100).withValues(alpha: 0.15), blurRadius: 60, spreadRadius: 5),



                    ],



                  ),



                  child: ClipRRect(



                    borderRadius: BorderRadius.circular(28),



                    child: Image.asset(



                      'assets/images/agroksha_logo.png',



                      fit: BoxFit.cover,



                      errorBuilder: (_, __, ___) => const Center(



                        child: Text('🌿', style: TextStyle(fontSize: 64)),



                      ),



                    ),



                  ),



                )



                    .animate()



                    .scale(begin: const Offset(0.3, 0.3), end: const Offset(1, 1), duration: 700.ms, curve: Curves.easeOutBack)



                    .fadeIn(duration: 500.ms),







                const SizedBox(height: 36),







                // App Name — AGROKSHA | AI



                Row(



                  mainAxisSize: MainAxisSize.min,



                  crossAxisAlignment: CrossAxisAlignment.baseline,



                  textBaseline: TextBaseline.alphabetic,



                  children: [



                    const Text(



                      'AGROKSHA',



                      style: TextStyle(



                        color: Colors.white,



                        fontSize: 30,



                        fontWeight: FontWeight.w900,



                        letterSpacing: 3,



                      ),



                    ),



                    const SizedBox(width: 8),



                    Container(



                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),



                      decoration: BoxDecoration(



                        color: const Color(0xFFE65100),



                        borderRadius: BorderRadius.circular(6),



                      ),



                      child: const Text(



                        'AI',



                        style: TextStyle(



                          color: Colors.white,



                          fontSize: 18,



                          fontWeight: FontWeight.w900,



                          letterSpacing: 1,



                        ),



                      ),



                    ),



                  ],



                )



                    .animate(delay: 400.ms)



                    .fadeIn(duration: 600.ms)



                    .slideY(begin: 0.3, curve: Curves.easeOutCubic),







                const SizedBox(height: 8),







                // Tagline



                const Text(



                  'Smart Farming. Intelligent Future.',



                  style: TextStyle(



                    color: Color(0xFF76FF03),



                    fontSize: 12,



                    fontWeight: FontWeight.w600,



                    letterSpacing: 1.5,



                  ),



                ).animate(delay: 700.ms).fadeIn(duration: 500.ms),







                const SizedBox(height: 6),







                Text(



                  'by TEAM SARA',



                  style: TextStyle(



                    color: Colors.white.withValues(alpha: 0.35),



                    fontSize: 11,



                    letterSpacing: 1,



                  ),



                ).animate(delay: 900.ms).fadeIn(duration: 400.ms),







                const SizedBox(height: 70),







                // Loading indicator



                SizedBox(



                  width: 60,



                  child: LinearProgressIndicator(



                    backgroundColor: Colors.white.withValues(alpha: 0.1),



                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE65100)),



                    borderRadius: BorderRadius.circular(50),



                  ),



                ).animate(delay: 1200.ms).fadeIn(),







                const SizedBox(height: 14),







                Text(



                  'Initializing AI systems... 🌾',



                  style: TextStyle(



                    color: Colors.white.withValues(alpha: 0.4),



                    fontSize: 11,



                    letterSpacing: 0.5,



                  ),



                ).animate(delay: 1400.ms).fadeIn(),



              ],



            ),



          ),







          // ── Bottom version bar ────────────────────────────────────────────



          Positioned(



            bottom: 20,



            left: 0, right: 0,



            child: Center(



              child: Text('v 2.0.0 | © 2025-26 TEAM SARA',



                style: TextStyle(color: Colors.white.withValues(alpha: 0.15), fontSize: 9, letterSpacing: 0.5)),



            ),



          ).animate(delay: 1600.ms).fadeIn(),



        ],



      ),



    );



  }



}







// ── Subtle tech grid overlay ─────────────────────────────────────────────────



class _GridPainter extends CustomPainter {



  @override



  void paint(Canvas canvas, Size size) {



    final paint = Paint()



      ..color = const Color(0xFF1B6E3D).withValues(alpha: 0.04)



      ..strokeWidth = 0.5;



    const spacing = 40.0;



    for (double x = 0; x < size.width; x += spacing) {



      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);



    }



    for (double y = 0; y < size.height; y += spacing) {



      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);



    }



  }



  @override



  bool shouldRepaint(_) => false;



}



