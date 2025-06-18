import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'utils/app_theme.dart';

class PlantDiaryApp extends StatelessWidget {
  const PlantDiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Diary',
      theme: AppTheme.lightTheme,
      home: const SplashCreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
