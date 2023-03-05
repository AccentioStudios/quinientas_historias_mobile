import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: readingBackgroundColor,
    primaryColor: primaryColor,
    fontFamily: GoogleFonts.lato().fontFamily,
    colorScheme: const ColorScheme.light().copyWith(
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      primaryContainer: primaryContainerColor,
      onPrimaryContainer: onPrimaryContainerColor,
      onBackground: onReadingBackgroundColor,
      background: readingBackgroundColor,
      secondary: secondaryColor,
      onSecondary: onSecondaryColor,
      secondaryContainer: secondaryContainerColor,
      onSecondaryContainer: onSecondaryContainerColor,
      tertiaryContainer: tertiaryContainerColor,
      onTertiaryContainer: onTertiaryContainerColor,
      onSurface: onSurfaceColor,
      onSurfaceVariant: onSurfaceVariantColor,
      error: errorColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      toolbarTextStyle: TextStyle(color: onReadingBackgroundColor),
      iconTheme: IconThemeData(color: onReadingBackgroundColor),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: backgroundDarkColor,
    primaryColor: primaryDarkColor,
    fontFamily: GoogleFonts.lato().fontFamily,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: primaryDarkColor,
      onPrimary: onPrimaryDarkColor,
      primaryContainer: primaryContainerDarkColor,
      onPrimaryContainer: onPrimaryContainerDarkColor,
      onBackground: onBackgroundDarkColor,
      background: backgroundDarkColor,
      secondary: secondaryDarkColor,
      onSecondary: onSecondaryDarkColor,
      secondaryContainer: secondaryContainerDarkColor,
      onSecondaryContainer: onSecondaryContainerDarkColor,
      tertiaryContainer: tertiaryContainerDarkColor,
      onTertiaryContainer: onTertiaryContainerDarkColor,
      onSurface: onSurfaceDarkColor,
      onSurfaceVariant: onSurfaceVariantDarkColor,
      error: errorDarkColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      toolbarTextStyle: TextStyle(color: onBackgroundDarkColor),
      iconTheme: IconThemeData(color: onBackgroundDarkColor),
    ),
  );
}
