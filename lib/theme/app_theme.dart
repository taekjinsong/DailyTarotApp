import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryDark = Color(0xFF1A0A2E);
  static const Color primaryPurple = Color(0xFF6C3483);
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color accentLight = Color(0xFFF5E6CC);
  static const Color cardBack = Color(0xFF2D1B4E);
  static const Color surfaceDark = Color(0xFF16082A);

  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryPurple,
        scaffoldBackgroundColor: primaryDark,
        colorScheme: const ColorScheme.dark(
          primary: primaryPurple,
          secondary: accentGold,
          surface: surfaceDark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: accentGold,
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: accentGold,
          ),
          headlineMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.6,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Colors.white60,
            height: 1.5,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: surfaceDark,
          selectedItemColor: accentGold,
          unselectedItemColor: Colors.white38,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      );

  static BoxDecoration get mysticGradient => const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [primaryDark, Color(0xFF0D0221), surfaceDark],
        ),
      );

  static BoxDecoration get cardDecoration => BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [cardBack, Color(0xFF3D2B5A)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: accentGold.withAlpha(77), width: 1),
        boxShadow: [
          BoxShadow(
            color: primaryPurple.withAlpha(77),
            blurRadius: 15,
            spreadRadius: 2,
          ),
        ],
      );
}
