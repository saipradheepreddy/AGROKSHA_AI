/// ─────────────────────────────────────────────────────────────────────────────



/// AGROKSHA AI — Main Entry Point v2



/// Initializes StorageService, then provides AppProvider to the widget tree



/// ─────────────────────────────────────────────────────────────────────────────







import 'package:flutter/material.dart';



import 'package:flutter/services.dart';



import 'package:flutter/foundation.dart';



import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';



import 'theme/app_theme.dart';



import 'utils/app_provider.dart';



import 'services/storage_service.dart';



import 'screens/splash_screen.dart';



import 'config/env_config.dart';



import 'services/connectivity_service.dart';







void main() async {



  WidgetsFlutterBinding.ensureInitialized();







  // ── Production error handling ────────────────────────────────────────



  // Suppress Flutter framework errors in release mode



  FlutterError.onError = (FlutterErrorDetails details) {



    if (kReleaseMode) {



      // In production: silently log, don't crash



      FlutterError.dumpErrorToConsole(details, forceReport: false);



    } else {



      FlutterError.presentError(details);



    }



  };







  // Catch all uncaught async errors



  PlatformDispatcher.instance.onError = (error, stack) {



    return true; // handled — prevents app crash



  };







  // Replace default red error screen with branded fallback



  ErrorWidget.builder = (FlutterErrorDetails details) {



    return Material(



      child: Container(



        color: AppColors.darkBackground,



        child: const Center(



          child: Column(mainAxisSize: MainAxisSize.min, children: [



            Text('🌾', style: TextStyle(fontSize: 48)),



            SizedBox(height: 12),



            Text('AGROKSHA AI', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, letterSpacing: 2, fontSize: 20)),



            SizedBox(height: 8),



            Text('Something went wrong.\nPlease restart the app.',



              textAlign: TextAlign.center,



              style: TextStyle(color: Colors.white54, fontSize: 13)),



          ]),



        ),



      ),



    );



  };







  // Lock to portrait



  await SystemChrome.setPreferredOrientations([



    DeviceOrientation.portraitUp,



    DeviceOrientation.portraitDown,



  ]);







  // Transparent status bar for immersive UI



  SystemChrome.setSystemUIOverlayStyle(



    const SystemUiOverlayStyle(



      statusBarColor: Colors.transparent,



      statusBarIconBrightness: Brightness.light,



      systemNavigationBarColor: Colors.transparent,



    ),



  );







  // Initialize shared preferences storage



  final storage = await StorageService.init();







  // Initialize environment variables securely



  await EnvConfig.init();

  // Initialize Supabase
  try {
    await Supabase.initialize(
      url: Env.supabaseUrl,
      anonKey: Env.supabaseAnonKey,
    );
    debugPrint('Supabase initialized successfully');
  } catch (e) {
    debugPrint('Supabase Initialization Error: $e');
  }







  // Start connectivity monitor



  ConnectivityService.instance.init(); // removed await







  runApp(



    ChangeNotifierProvider(



      create: (_) => AppProvider(storage),



      child: const AgroKshaApp(),



    ),



  );



}







/// Root application widget



class AgroKshaApp extends StatelessWidget {



  const AgroKshaApp({super.key});







  @override



  Widget build(BuildContext context) {



    return Consumer<AppProvider>(



      builder: (context, provider, _) {



        return MaterialApp(



          title: 'AGROKSHA AI',



          debugShowCheckedModeBanner: false,



          theme: AppTheme.lightTheme,



          darkTheme: AppTheme.darkTheme,



          themeMode: provider.themeMode,



          home: const SplashScreen(),



          builder: (context, child) {



            return MediaQuery(



              data: MediaQuery.of(context).copyWith(



                // Prevent font scaling from breaking layout on accessibility settings



                textScaler: const TextScaler.linear(1.0),



              ),



              child: child!,



            );



          },



        );



      },



    );



  }



}



