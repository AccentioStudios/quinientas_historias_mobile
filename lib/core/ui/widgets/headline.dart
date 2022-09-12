import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class Headline extends StatelessWidget {
  const Headline(
      {Key? key,
      required this.label,
      this.linkText,
      this.onTap,
      this.marginTop = Constants.space41,
      this.marginBottom = Constants.space21,
      this.fontSize = 20})
      : super(key: key);
  final String label;
  final String? linkText;
  final GestureTapCallback? onTap;
  final double marginTop;
  final double marginBottom;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: marginTop),
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  letterSpacing: 0.5,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: linkText != null
                  ? Text(
                      linkText!,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.secondary),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
        SizedBox(height: marginBottom),
      ],
    );
  }
}
