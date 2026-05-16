import 'package:flutter/material.dart';




import 'package:google_fonts/google_fonts.dart';









/// ─────────────────────────────────────────────────────────────────────────────




/// AGROKSHA AI — Premium Nature-Inspired Theme




/// Material 3 design system with green + white + dark accents




/// ─────────────────────────────────────────────────────────────────────────────









class AppColors {




  AppColors._();









  // ── Primary Greens ──




  static const Color primary = Color(0xFF1B6E3D);




  static const Color primaryLight = Color(0xFF2E9659);




  static const Color primaryLighter = Color(0xFF4CAF73);




  static const Color primarySurface = Color(0xFFE8F5EE);









  // ── AGROKSHA AI Brand Accent ──




  static const Color brandOrange = Color(0xFFE65100);  // "AI" orange from logo




  static const Color brandNeonGreen = Color(0xFF76FF03); // Neon green tagline









  // ── Accent / Secondary ──




  static const Color accent = Color(0xFF70C16B);




  static const Color accentAmber = Color(0xFFFFB74D);




  static const Color accentSky = Color(0xFF4FC3F7);









  // ── Risk Colors ──




  static const Color riskHigh = Color(0xFFE53935);




  static const Color riskMedium = Color(0xFFFFA726);




  static const Color riskLow = Color(0xFF43A047);




  static const Color riskNone = Color(0xFF2E9659);









  // ── Surface / Background ──




  static const Color background = Color(0xFFF5FAF7);




  static const Color surfaceWhite = Color(0xFFFFFFFF);




  static const Color cardSurface = Color(0xFFFFFFFF);




  static const Color divider = Color(0xFFE0EDE5);









  // ── Text ──




  static const Color textDark = Color(0xFF1A2E1F);




  static const Color textMedium = Color(0xFF4A6351);




  static const Color textLight = Color(0xFF8CA997);




  static const Color textOnPrimary = Color(0xFFFFFFFF);









  // ── Dark Mode ──




  static const Color darkBackground = Color(0xFF0D1F13);




  static const Color darkSurface = Color(0xFF162419);




  static const Color darkCard = Color(0xFF1E3024);




  static const Color darkText = Color(0xFFE6F4EB);




  static const Color darkTextMedium = Color(0xFF9EC9AA);









  // ── Gradient presets ──




  static const LinearGradient primaryGradient = LinearGradient(




    begin: Alignment.topLeft,




    end: Alignment.bottomRight,




    colors: [Color(0xFF1B6E3D), Color(0xFF2E9659)],




  );









  static const LinearGradient heroGradient = LinearGradient(




    begin: Alignment.topCenter,




    end: Alignment.bottomCenter,




    colors: [Color(0xFF050E07), Color(0xFF0A1F10), Color(0xFF1B6E3D)],




  );









  // AGROKSHA dark premium gradient (used in splash/login header)




  static const LinearGradient darkPremiumGradient = LinearGradient(




    begin: Alignment.topLeft,




    end: Alignment.bottomRight,




    colors: [Color(0xFF050E07), Color(0xFF0A1F10), Color(0xFF0F2E17)],




  );









  static const LinearGradient skyGradient = LinearGradient(




    begin: Alignment.topLeft,




    end: Alignment.bottomRight,




    colors: [Color(0xFF1565C0), Color(0xFF0288D1), Color(0xFF4FC3F7)],




  );




}









class AppTheme {




  AppTheme._();









  // ── Shadow presets ──




  static List<BoxShadow> get cardShadow => [




        BoxShadow(




          color: AppColors.primary.withValues(alpha: 0.08),




          blurRadius: 20,




          offset: const Offset(0, 6),




          spreadRadius: 0,




        ),




      ];









  static List<BoxShadow> get elevatedShadow => [




        BoxShadow(




          color: AppColors.primary.withValues(alpha: 0.15),




          blurRadius: 30,




          offset: const Offset(0, 10),




          spreadRadius: -5,




        ),




      ];









  // ── Border Radius presets ──




  static BorderRadius get cardRadius => BorderRadius.circular(20);




  static BorderRadius get buttonRadius => BorderRadius.circular(16);




  static BorderRadius get chipRadius => BorderRadius.circular(50);









  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━




  // LIGHT THEME




  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━




  static ThemeData lightTheme = ThemeData(




    useMaterial3: true,




    brightness: Brightness.light,




    colorScheme: ColorScheme.fromSeed(




      seedColor: AppColors.primary,




      brightness: Brightness.light,




      primary: AppColors.primary,




      secondary: AppColors.accent,




      surface: AppColors.surfaceWhite,




      onPrimary: Colors.white,




      onSurface: AppColors.textDark,




    ),




    scaffoldBackgroundColor: AppColors.background,




    textTheme: _buildTextTheme(isDark: false),




    appBarTheme: AppBarTheme(




      backgroundColor: Colors.transparent,




      elevation: 0,




      scrolledUnderElevation: 0,




      centerTitle: false,




      titleTextStyle: GoogleFonts.poppins(




        color: AppColors.textDark,




        fontSize: 20,




        fontWeight: FontWeight.w700,




      ),




      iconTheme: const IconThemeData(color: AppColors.textDark),




    ),




    cardTheme: CardThemeData(




      elevation: 0,




      color: AppColors.cardSurface,




      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),




      margin: EdgeInsets.zero,




    ),




    elevatedButtonTheme: ElevatedButtonThemeData(




      style: ElevatedButton.styleFrom(




        backgroundColor: AppColors.primary,




        foregroundColor: Colors.white,




        elevation: 0,




        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),




        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),




        textStyle: GoogleFonts.poppins(




          fontSize: 16,




          fontWeight: FontWeight.w600,




          letterSpacing: 0.3,




        ),




      ),




    ),




    outlinedButtonTheme: OutlinedButtonThemeData(




      style: OutlinedButton.styleFrom(




        foregroundColor: AppColors.primary,




        side: const BorderSide(color: AppColors.primary, width: 1.5),




        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),




        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),




        textStyle: GoogleFonts.poppins(




          fontSize: 16,




          fontWeight: FontWeight.w600,




        ),




      ),




    ),




    inputDecorationTheme: InputDecorationTheme(




      filled: true,




      fillColor: Colors.white,




      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),




      border: OutlineInputBorder(




        borderRadius: BorderRadius.circular(14),




        borderSide: const BorderSide(color: AppColors.divider, width: 1.5),




      ),




      enabledBorder: OutlineInputBorder(




        borderRadius: BorderRadius.circular(14),




        borderSide: const BorderSide(color: AppColors.divider, width: 1.5),




      ),




      focusedBorder: OutlineInputBorder(




        borderRadius: BorderRadius.circular(14),




        borderSide: const BorderSide(color: AppColors.primary, width: 2),




      ),




      errorBorder: OutlineInputBorder(




        borderRadius: BorderRadius.circular(14),




        borderSide: const BorderSide(color: AppColors.riskHigh, width: 1.5),




      ),




      labelStyle: GoogleFonts.poppins(color: AppColors.textMedium, fontSize: 14),




      hintStyle: GoogleFonts.poppins(color: AppColors.textLight, fontSize: 14),




    ),




    chipTheme: ChipThemeData(




      backgroundColor: AppColors.primarySurface,




      selectedColor: AppColors.primary,




      labelStyle: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500),




      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),




      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),




    ),




    snackBarTheme: SnackBarThemeData(




      backgroundColor: AppColors.textDark,




      contentTextStyle: GoogleFonts.poppins(color: Colors.white, fontSize: 13),




      behavior: SnackBarBehavior.floating,




      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),




    ),




    dividerTheme: const DividerThemeData(




      color: AppColors.divider,




      thickness: 1,




    ),




    pageTransitionsTheme: const PageTransitionsTheme(




      builders: {




        TargetPlatform.android: CupertinoPageTransitionsBuilder(),




        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),




      },




    ),




  );









  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━




  // DARK THEME




  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━




  static ThemeData darkTheme = ThemeData(




    useMaterial3: true,




    brightness: Brightness.dark,




    colorScheme: ColorScheme.fromSeed(




      seedColor: AppColors.primary,




      brightness: Brightness.dark,




      primary: AppColors.primaryLight,




      secondary: AppColors.accent,




      surface: AppColors.darkSurface,




      onPrimary: Colors.white,




      onSurface: AppColors.darkText,




    ),




    scaffoldBackgroundColor: AppColors.darkBackground,




    textTheme: _buildTextTheme(isDark: true),




    appBarTheme: AppBarTheme(




      backgroundColor: Colors.transparent,




      elevation: 0,




      scrolledUnderElevation: 0,




      centerTitle: false,




      titleTextStyle: GoogleFonts.poppins(




        color: AppColors.darkText,




        fontSize: 20,




        fontWeight: FontWeight.w700,




      ),




      iconTheme: const IconThemeData(color: AppColors.darkText),




    ),




    cardTheme: CardThemeData(




      elevation: 0,




      color: AppColors.darkCard,




      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),




      margin: EdgeInsets.zero,




    ),




    elevatedButtonTheme: ElevatedButtonThemeData(




      style: ElevatedButton.styleFrom(




        backgroundColor: AppColors.primaryLight,




        foregroundColor: Colors.white,




        elevation: 0,




        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),




        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),




        textStyle: GoogleFonts.poppins(




          fontSize: 16,




          fontWeight: FontWeight.w600,




          letterSpacing: 0.3,




        ),




      ),




    ),




    inputDecorationTheme: InputDecorationTheme(




      filled: true,




      fillColor: AppColors.darkCard,




      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),




      border: OutlineInputBorder(




        borderRadius: BorderRadius.circular(14),




        borderSide: BorderSide(color: AppColors.primaryLight.withValues(alpha: 0.3), width: 1.5),




      ),




      enabledBorder: OutlineInputBorder(




        borderRadius: BorderRadius.circular(14),




        borderSide: BorderSide(color: AppColors.primaryLight.withValues(alpha: 0.3), width: 1.5),




      ),




      focusedBorder: OutlineInputBorder(




        borderRadius: BorderRadius.circular(14),




        borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),




      ),




      labelStyle: GoogleFonts.poppins(color: AppColors.darkTextMedium, fontSize: 14),




      hintStyle: GoogleFonts.poppins(color: AppColors.darkTextMedium, fontSize: 14),




    ),




    snackBarTheme: SnackBarThemeData(




      backgroundColor: AppColors.darkCard,




      contentTextStyle: GoogleFonts.poppins(color: AppColors.darkText, fontSize: 13),




      behavior: SnackBarBehavior.floating,




      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),




    ),




  );









  // ── Text theme builder ──




  static TextTheme _buildTextTheme({required bool isDark}) {




    final Color base = isDark ? AppColors.darkText : AppColors.textDark;




    final Color medium = isDark ? AppColors.darkTextMedium : AppColors.textMedium;









    return TextTheme(




      displayLarge: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w800, color: base),




      displayMedium: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w700, color: base),




      displaySmall: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700, color: base),




      headlineLarge: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w700, color: base),




      headlineMedium: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600, color: base),




      headlineSmall: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: base),




      titleLarge: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: base),




      titleMedium: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: base),




      titleSmall: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600, color: medium),




      bodyLarge: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400, color: base),




      bodyMedium: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400, color: base),




      bodySmall: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400, color: medium),




      labelLarge: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, letterSpacing: 0.5),




      labelMedium: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: medium),




      labelSmall: GoogleFonts.poppins(fontSize: 11, fontWeight: FontWeight.w500, letterSpacing: 0.8, color: medium),




    );




  }




}




