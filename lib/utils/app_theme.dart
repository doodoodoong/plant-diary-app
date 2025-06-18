import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Colors.green;
  static const Color backgroundColor = Colors.white;
  static const Color errorColor = Colors.red;
  static const Color surfaceColor = Color(0xFFF5F5F5);

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.green,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,

      // 아이패드에 최적화된 AppBar 테마
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        centerTitle: true,
        toolbarHeight: 70, // 아이패드에서 더 큰 높이
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // 아이패드용 FloatingActionButton 테마
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // 버튼 테마
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // 프로그레스 인디케이터 테마
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryColor,
        linearTrackColor: Color(0xFFE0E0E0),
        circularTrackColor: Color(0xFFE0E0E0),
      ),

      // 카드 테마 (아이패드에서 사용할 수 있는 섹션들)
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),

      // 텍스트 테마 (아이패드 최적화)
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        bodyLarge: TextStyle(fontSize: 18, color: Colors.black87),
        bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
      ),
    );
  }
}
