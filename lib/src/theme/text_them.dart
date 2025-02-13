import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme appTextTheme(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  return TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: width * 0.06,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: width * 0.055,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: width * 0.05,
    ),
    headlineLarge: GoogleFonts.poppins(
      fontSize: width * 0.045,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: width * 0.04,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: width * 0.035,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: width * 0.032,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: width * 0.03,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: width * 0.028,
    ),
    bodyLarge: GoogleFonts.poppins(fontSize: width * 0.025),
    bodyMedium: GoogleFonts.poppins(
      fontSize: width * 0.02,
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: width * 0.017,
    ),
    labelLarge: GoogleFonts.poppins(fontSize: width * 0.015),
    labelMedium: GoogleFonts.poppins(
      fontSize: width * 0.01,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: width * 0.005,
    ),
  );
}
