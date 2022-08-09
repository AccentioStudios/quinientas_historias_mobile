import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/colors.dart';

enum ArrowPositionDirection { up, down, none }

class ArrowPosition extends StatelessWidget {
  const ArrowPosition({Key? key, required this.arrowPositionDirection})
      : super(key: key);
  final ArrowPositionDirection arrowPositionDirection;
  @override
  Widget build(BuildContext context) {
    return buildArrow(context, arrowPositionDirection);
  }

  Widget buildArrow(
      BuildContext context, ArrowPositionDirection arrowPositionDirection) {
    switch (arrowPositionDirection) {
      case ArrowPositionDirection.up:
        return SvgPicture.asset(
          'assets/icons/arrow-up.svg',
          color: buildColor(context, arrowPositionDirection),
        );
      case ArrowPositionDirection.down:
        return SvgPicture.asset(
          'assets/icons/arrow-down.svg',
          color: buildColor(context, arrowPositionDirection),
        );
      case ArrowPositionDirection.none:
        return SvgPicture.asset(
          'assets/icons/arrow-none.svg',
          color: buildColor(context, arrowPositionDirection),
        );
    }
  }

  Color buildColor(
      BuildContext context, ArrowPositionDirection arrowPositionDirection) {
    final lightTheme = Theme.of(context).brightness == Brightness.light;
    switch (arrowPositionDirection) {
      case ArrowPositionDirection.up:
        return lightTheme ? successColor : successDarkColor;
      case ArrowPositionDirection.down:
        return lightTheme ? errorColor : errorDarkColor;
      case ArrowPositionDirection.none:
        return lightTheme ? onSurfaceVariantColor : onSurfaceVariantDarkColor;
    }
  }
}
