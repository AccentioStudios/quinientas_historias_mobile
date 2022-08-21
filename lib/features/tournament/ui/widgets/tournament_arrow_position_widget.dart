import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/data/models/leaderboard_model.dart';
import '../../../../core/utils/colors.dart';

enum ArrowPositionDirection { up, down, none }

class ArrowPosition extends StatelessWidget {
  const ArrowPosition({Key? key, required this.arrowPositionDirection})
      : super(key: key);
  final LeaderboardChangePositionType arrowPositionDirection;
  @override
  Widget build(BuildContext context) {
    return buildArrow(context, arrowPositionDirection);
  }

  Widget buildArrow(BuildContext context,
      LeaderboardChangePositionType arrowPositionDirection) {
    switch (arrowPositionDirection) {
      case LeaderboardChangePositionType.positive:
        return SvgPicture.asset(
          'assets/icons/arrow-up.svg',
          color: buildColor(context, arrowPositionDirection),
        );
      case LeaderboardChangePositionType.negative:
        return SvgPicture.asset(
          'assets/icons/arrow-down.svg',
          color: buildColor(context, arrowPositionDirection),
        );
      case LeaderboardChangePositionType.neutral:
        return SvgPicture.asset(
          'assets/icons/arrow-none.svg',
          color: buildColor(context, arrowPositionDirection),
        );
    }
  }

  Color buildColor(BuildContext context,
      LeaderboardChangePositionType arrowPositionDirection) {
    final lightTheme = Theme.of(context).brightness == Brightness.light;
    switch (arrowPositionDirection) {
      case LeaderboardChangePositionType.positive:
        return lightTheme ? successColor : successDarkColor;
      case LeaderboardChangePositionType.negative:
        return lightTheme ? errorColor : errorDarkColor;
      case LeaderboardChangePositionType.neutral:
        return lightTheme ? onSurfaceVariantColor : onSurfaceVariantDarkColor;
    }
  }
}
