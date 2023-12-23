import 'package:flutter/material.dart';
import 'package:sheeta/static/colors.dart';
// import 'package:google_fonts/google_fonts.dart';

ThemeData mainTheme = ThemeData(
  useMaterial3: true,

  // Define the default brightness and colors.
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    // ···
    brightness: Brightness.dark,
  ),

  primaryColor: primaryColor,

  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  // textTheme: TextTheme(
  //   titleLarge: GoogleFonts.ptSans(
  //     fontStyle: FontStyle.italic,
  //   ),
  //   bodyMedium: GoogleFonts.ptSans(),
  //   displaySmall: GoogleFonts.ptSans(),
  // ),

  // select the background color of all screens
  scaffoldBackgroundColor: mobBg,
);
