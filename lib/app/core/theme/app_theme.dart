import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFF1E88E5),
      scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1E88E5),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
