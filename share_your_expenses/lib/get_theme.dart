import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme() {
  return ThemeData(
    textTheme: TextTheme(
      headline1: TextStyle(
        fontFamily: GoogleFonts.lacquer().fontFamily,
      ),
      headline2: TextStyle(
        fontFamily: GoogleFonts.lacquer().fontFamily,
      ),
      headline5: TextStyle(
        fontFamily: GoogleFonts.lacquer().fontFamily,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.lato().fontFamily,
  );
}
