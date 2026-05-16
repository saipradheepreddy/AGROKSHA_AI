/// ─────────────────────────────────────────────────────────────────────────────



/// AGROKSHA AI — Custom Logo Widget



/// Reusable branded logo used on splash, login, app bar, about page



/// No image assets needed — purely drawn with Flutter widgets



/// ─────────────────────────────────────────────────────────────────────────────







library;







import 'package:flutter/material.dart';



import '../theme/app_theme.dart';







/// AGROKSHA AI custom logo.



/// [size] controls the outer container size (default 80).



/// [onDark] switches the color scheme for dark/gradient backgrounds.



class AgriLogo extends StatelessWidget {



  final double size;



  final bool onDark;



  final bool showText;







  const AgriLogo({



    super.key,



    this.size = 80,



    this.onDark = false,



    this.showText = false,



  });







  @override



  Widget build(BuildContext context) {



    return Column(



      mainAxisSize: MainAxisSize.min,



      children: [



        // Icon container



        Container(



          width: size,



          height: size,



          decoration: BoxDecoration(



            gradient: onDark



                ? const LinearGradient(



                    begin: Alignment.topLeft,



                    end: Alignment.bottomRight,



                    colors: [Color(0xFF2E9659), Color(0xFF70C16B)],



                  )



                : AppColors.primaryGradient,



            borderRadius: BorderRadius.circular(size * 0.26),



            boxShadow: [



              BoxShadow(



                color: AppColors.primary.withValues(alpha: 0.35),



                blurRadius: size * 0.4,



                offset: Offset(0, size * 0.1),



              ),



            ],



          ),



          child: Stack(



            alignment: Alignment.center,



            children: [



              // Background circle glow



              Container(



                width: size * 0.62,



                height: size * 0.62,



                decoration: BoxDecoration(



                  color: Colors.white.withValues(alpha: 0.12),



                  shape: BoxShape.circle,



                ),



              ),



              // Leaf icon (main)



              Positioned(



                bottom: size * 0.16,



                left: size * 0.18,



                child: Transform.rotate(



                  angle: -0.3,



                  child: Icon(



                    Icons.eco_rounded,



                    color: Colors.white,



                    size: size * 0.52,



                  ),



                ),



              ),



              // AI chip / sparkle



              Positioned(



                top: size * 0.12,



                right: size * 0.12,



                child: Container(



                  padding: EdgeInsets.symmetric(



                    horizontal: size * 0.06,



                    vertical: size * 0.025,



                  ),



                  decoration: BoxDecoration(



                    color: Colors.white.withValues(alpha: 0.9),



                    borderRadius: BorderRadius.circular(size * 0.1),



                  ),



                  child: Text(



                    'AI',



                    style: TextStyle(



                      color: AppColors.primary,



                      fontSize: size * 0.13,



                      fontWeight: FontWeight.w900,



                      letterSpacing: 0.5,



                      height: 1,



                    ),



                  ),



                ),



              ),



            ],



          ),



        ),



        if (showText) ...[



          SizedBox(height: size * 0.14),



          Text(



            'AGROKSHA AI',



            style: TextStyle(



              color: onDark ? Colors.white : AppColors.textDark,



              fontSize: size * 0.2,



              fontWeight: FontWeight.w800,



              letterSpacing: 2,



            ),



          ),



          SizedBox(height: size * 0.04),



          Text(



            'Smart Farming for a Better Tomorrow',



            style: TextStyle(



              color: onDark



                  ? Colors.white.withValues(alpha: 0.7)



                  : AppColors.textLight,



              fontSize: size * 0.12,



              fontWeight: FontWeight.w500,



            ),



            textAlign: TextAlign.center,



          ),



        ],



      ],



    );



  }



}







/// Small inline logo for app bars (just icon, no text)



class AgriLogoSmall extends StatelessWidget {



  final double size;



  const AgriLogoSmall({super.key, this.size = 36});







  @override



  Widget build(BuildContext context) => AgriLogo(size: size, onDark: true);



}








