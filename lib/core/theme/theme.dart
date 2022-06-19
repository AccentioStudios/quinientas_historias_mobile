import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

var appTheme = ThemeData(
  backgroundColor: backgroundColor,
  scaffoldBackgroundColor: backgroundColor,
  primaryColor: primaryColor,
  textTheme: GoogleFonts.montserratTextTheme(),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: backgroundDarkColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: primaryColor,
    onPrimary: onPrimaryColor,
    primaryContainer: primaryContainerColor,
    onPrimaryContainer: onPrimaryContainerColor,
    onBackground: onBackgroundColor,
    background: backgroundColor,
    secondary: secondaryColor,
    onSecondary: onSecondaryColor,
  ),
);
