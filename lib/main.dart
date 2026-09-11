import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/main_navigation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(
    const ProviderScope(
      child: YksifyApp(),
    ),
  );
}

class YksifyApp extends StatelessWidget {
  const YksifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = Theme.of(context).textTheme;

    return MaterialApp(
      title: 'YKSify - TYT & AYT Hazırlık',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF58CC02),
          primary: const Color(0xFF58CC02),
          secondary: const Color(0xFF1CB0F6),
          error: const Color(0xFFFF4B4B),
        ),
        textTheme: GoogleFonts.nunitoTextTheme(baseTextTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

typedef YksPatikaApp = YksifyApp;
typedef YksPatikaAppAlias = YksifyApp;
typedef YksCepteApp = YksifyApp;
typedef YksLingoApp = YksifyApp;
