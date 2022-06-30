import 'package:flutter/material.dart';
import '../utils/colors.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: readingBackgroundColor,
    primaryColor: primaryColor,
    backgroundColor: readingBackgroundColor,
    textTheme: ThemeData.light().textTheme,
    fontFamily: 'Proxima Nova',
    colorScheme: const ColorScheme.light().copyWith(
      primary: primaryColor,
      onPrimary: onPrimaryColor,
      primaryContainer: primaryContainerColor,
      onPrimaryContainer: onPrimaryContainerColor,
      onBackground: onReadingBackgroundColor,
      background: readingBackgroundColor,
      secondary: secondaryColor,
      onSecondary: onSecondaryColor,
      tertiaryContainer: tertiaryContainerColor,
      onTertiaryContainer: onTertiaryContainerColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: backgroundDarkColor,
    primaryColor: primaryDarkColor,
    backgroundColor: backgroundDarkColor,
    textTheme: ThemeData.dark().textTheme,
    fontFamily: 'Proxima Nova',
    colorScheme: const ColorScheme.dark().copyWith(
      primary: primaryDarkColor,
      onPrimary: onPrimaryDarkColor,
      primaryContainer: primaryContainerDarkColor,
      onPrimaryContainer: onPrimaryContainerDarkColor,
      onBackground: onBackgroundDarkColor,
      background: backgroundDarkColor,
      secondary: secondaryDarkColor,
      onSecondary: onSecondaryDarkColor,
      tertiaryContainer: tertiaryContainerDarkColor,
      onTertiaryContainer: onTertiaryContainerDarkColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
    ),
  );
}
