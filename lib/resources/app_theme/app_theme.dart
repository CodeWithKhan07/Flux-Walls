import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFF13ecda);
  static const Color backgroundDark = Color(0xFF102220);
  static const Color surfaceTonal = Color(0xFF1c312f);

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF102220),
// --- Button Themes ---
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: backgroundDark,
        textStyle: const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

    // --- Icon Styling ---
    iconTheme: const IconThemeData(
      color: primary,
      size: 24,
    ),

    // --- Floating Action Button ---
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: backgroundDark,
      shape: CircleBorder(),
    ),
    // Apply Poppins to the entire TextTheme
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    ).copyWith(
      // --- Titles / Headlines ---
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),

      // --- Body Text ---
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white70,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: Colors.white54,
      ),
    ),
  );
}