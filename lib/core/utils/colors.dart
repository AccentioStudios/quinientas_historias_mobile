import 'package:flutter/material.dart';
import 'dart:math' as math;

const readingBackgroundColor = Color(0xFFFFE3C7);
const onReadingBackgroundColor = Color(0xFF472300);
const primaryColor = Color(0xFFFF9900);
const onPrimaryColor = Color(0xFF1A1C1F);
const primaryMutedColor = Color(0xFFB5A79A);
const onPrimaryMutedColor = Color(0xFF695F56);
const secondaryColor = Color(0xFF8B5000);
const onSecondaryColor = Colors.white;
const primaryContainerColor = Color(0xFFD5E3FF);
const onPrimaryContainerColor = Color(0xFF001B3F);
const secondaryContainerColor = Color(0xFFFFDCBA);
const onSecondaryContainerColor = Color(0xFF2D1600);
const tertiaryContainerColor = Color(0xFF69FBCB);
const onTertiaryContainerColor = Color(0xFFFFFFFF);
const streakFireRedColor = Color(0xFFFF5D5D);
const onSurfaceColor = Color(0xFF1A1C1F);
const onSurfaceVariantColor = Color(0xFF44474F);
const successColor = Color(0xFF69FBCB);
const errorColor = Color(0xFFFF7B5B);

const backgroundDarkColor = Color(0xFF101C29);
const onBackgroundDarkColor = Color(0xFFE3E2E6);
const primaryDarkColor = Color(0xFFFFDCBA);
const onPrimaryDarkColor = Color(0xFF2D1600);
const primaryMutedDarkColor = Color(0xFFB5A79A);
const onPrimaryMutedDarkColor = Color(0xFF695F56);
const secondaryDarkColor = Color(0xFFBBDCF2);
const onSecondaryDarkColor = Color(0xFF4A2800);
const primaryContainerDarkColor = Color(0xFF1D2B3B);
const onPrimaryContainerDarkColor = Color(0xFFE3E2E6);
const secondaryContainerDarkColor = Color(0xFF6A3C00);
const onSecondaryContainerDarkColor = Color(0xFFFFDCBA);
const onSurfaceMutedTextDarkColor = Color(0xFFB6B6B6);
const tertiaryContainerDarkColor = Color(0xFF00513B);
const onTertiaryContainerDarkColor = Color(0xFF69FBCB);
const streakFireRedDarkColor = Color(0xFFFF5D5D);
const onSurfaceDarkColor = Color(0xFFE3E2E6);
const onSurfaceVariantDarkColor = Color(0xFFC4C6CF);
const successDarkColor = Color(0xFF69FBCB);
const errorDarkColor = Color(0xFFFF7B5B);

// Division Colors
const division1Color = Color(0xFFA8602C);
const division2Color = Color(0xFF8A8984);
const division3Color = Color(0xFFA79536);
const division4Color = Color(0xFF5A9D49);
const division5Color = Color(0xFF8C317E);

Color generateRandomColors() {
  const List<Color> rangeOfRandomColors = [
    Color(0xFFFFCD81),
    Color(0xFF88C9F9),
    Color(0xFFADE9B3),
    Color(0xFFC494F3),
    Color(0xFFF3ABAB),
    Color(0xFFFF8FC4),
    Color(0xFF72AFE5),
    Color(0xFFDAC99D),
    Color(0xFFB2AAEE),
  ];
  math.Random random = math.Random();
  int cindex = random.nextInt(rangeOfRandomColors.length);
  return rangeOfRandomColors[cindex];
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
