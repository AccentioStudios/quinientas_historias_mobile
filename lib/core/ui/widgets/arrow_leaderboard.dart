import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/colors.dart';

class ArrowLeaderBoard extends StatelessWidget {
  const ArrowLeaderBoard({
    Key? key,
    this.number = 0,
    this.positive = true,
  }) : super(key: key);
  final int number;
  final bool positive;
  @override
  Widget build(BuildContext context) {
    Color color = getColor(context, positive);
    return Row(
      children: [
        Text(
          number.toString(),
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: color),
        ),
        SvgPicture.asset(
          positive
              ? 'assets/icons/arrow-up.svg'
              : 'assets/icons/arrow-down.svg',
          color: color,
        ),
      ],
    );
  }

  Color getColor(BuildContext context, bool positive) {
    Color color = positive
        ? Theme.of(context).brightness == Brightness.light
            ? successColor
            : successDarkColor
        : Theme.of(context).brightness == Brightness.light
            ? errorColor
            : errorDarkColor;

    return color;
  }
}
