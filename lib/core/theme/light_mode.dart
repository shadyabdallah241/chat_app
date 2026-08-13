import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,

  colorScheme: ColorScheme.light(
    surface: const Color(0xFFF2F2F2),
    primary: const Color(0xFF666666),
    secondary: const Color(0xFFE2E2E2),
    tertiary: Colors.white,
    inversePrimary: const Color(0xFF181818),
  ),

  scaffoldBackgroundColor: const Color(0xFFF7F7F7),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF7F7F7),
    elevation: 0,
  ),

  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 1,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
  ),
);
