import 'package:flutter/material.dart';

// Primary colors
const Color primaryColor = Color.fromARGB(255, 252, 83, 83);

// Neutral colors
const Color grey = Color(0xFF555555);
const Color greyInputs = Color(0xFFf4f6f9);
const Color greyLight = Color(0xFFC4C4C4);

// Accent colors
const Color mintAccent = Color(0xFF6dc8c2);
const Color yellowAccent = Color(0xFFffbb45);
const Color redAccent = Color(0xFFf74048);
const Color greenAccent = Color(0xFF4CD964);
const Color violetAccent = Color(0xFF390D97);

class AppTheme {
  static final ThemeData normalTheme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(primary: primaryColor),
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white, // Background color of the AppBar
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 35,
    ),
  );
}
