import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/exam_provider.dart';
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
      child: YksQuestApp(),
    ),
  );
}

class YksQuestApp extends ConsumerWidget {
  const YksQuestApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseTextTheme = Theme.of(context).textTheme;
    final activeExam = ref.watch(examConfigProvider);

    return MaterialApp(
      title: '${activeExam.title} - ${activeExam.description}',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: activeExam.primaryColor,
          primary: activeExam.primaryColor,
          secondary: activeExam.secondaryColor,
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

typedef YksifyApp = YksQuestApp;
typedef YksPatikaApp = YksQuestApp;
typedef YksPatikaAppAlias = YksQuestApp;
typedef YksCepteApp = YksQuestApp;
typedef YksLingoApp = YksQuestApp;
