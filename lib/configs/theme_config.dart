import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final themeData = ThemeData(
  useMaterial3: true,
  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.black54),
  scaffoldBackgroundColor: Colors.black,
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 75, 183, 165)),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 25,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.inter(
        fontSize: 20, fontStyle: FontStyle.normal, fontWeight: FontWeight.w600),
    bodyMedium: GoogleFonts.inter(fontSize: 20),
  ),
);
