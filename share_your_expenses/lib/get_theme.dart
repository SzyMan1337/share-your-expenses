import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme() {
  return ThemeData(
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: GoogleFonts.lacquer().fontFamily,
      ),
      displayMedium: TextStyle(
        fontFamily: GoogleFonts.lacquer().fontFamily,
      ),
      headlineSmall: TextStyle(
        fontFamily: GoogleFonts.lacquer().fontFamily,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.lato().fontFamily,
  );
}
