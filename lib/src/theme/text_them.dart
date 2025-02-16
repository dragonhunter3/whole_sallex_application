import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';

TextTheme appTextTheme(BuildContext context) {
  final width = MediaQuery.of(context).size.width;

  return TextTheme(
    displayLarge: GoogleFonts.poppins(
        fontSize: width * 0.06, color: colorScheme(context).surface),
    displayMedium: GoogleFonts.poppins(
        fontSize: width * 0.055, color: colorScheme(context).surface),
    displaySmall: GoogleFonts.poppins(
        fontSize: width * 0.05, color: colorScheme(context).surface),
    headlineLarge: GoogleFonts.poppins(
        fontSize: width * 0.045, color: colorScheme(context).surface),
    headlineMedium: GoogleFonts.poppins(
        fontSize: width * 0.04, color: colorScheme(context).surface),
    headlineSmall: GoogleFonts.poppins(
        fontSize: width * 0.035, color: colorScheme(context).surface),
    titleLarge: GoogleFonts.poppins(
        fontSize: width * 0.032, color: colorScheme(context).surface),
    titleMedium: GoogleFonts.poppins(
        fontSize: width * 0.03, color: colorScheme(context).surface),
    titleSmall: GoogleFonts.poppins(
        fontSize: width * 0.028, color: colorScheme(context).surface),
    bodyLarge: GoogleFonts.poppins(
        fontSize: width * 0.025, color: colorScheme(context).surface),
    bodyMedium: GoogleFonts.poppins(
        fontSize: width * 0.02, color: colorScheme(context).surface),
    bodySmall: GoogleFonts.poppins(
        fontSize: width * 0.017, color: colorScheme(context).surface),
    labelLarge: GoogleFonts.poppins(
        fontSize: width * 0.015, color: colorScheme(context).surface),
    labelMedium: GoogleFonts.poppins(
        fontSize: width * 0.01, color: colorScheme(context).surface),
    labelSmall: GoogleFonts.poppins(
        fontSize: width * 0.005, color: colorScheme(context).surface),
  );
}
