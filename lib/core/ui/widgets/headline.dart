import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class Headline extends StatelessWidget {
  const Headline(
      {Key? key,
      required this.label,
      this.secondaryLabel,
      this.linkText,
      this.onTap,
      this.marginTop = Constants.space30,
      this.marginBottom = Constants.space21,
      this.fontSize = 18})
      : super(key: key);
  final String label;
  final String? secondaryLabel;
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
              child: AutoSizeText.rich(
                TextSpan(
                  text: '$label ',
                  style: TextStyle(
                    letterSpacing: 0.5,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                maxLines: 2,
                maxFontSize: fontSize - 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: Constants.space8),
              child: GestureDetector(
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
            ),
          ],
        ),
        if (secondaryLabel != null)
          Padding(
            padding: const EdgeInsets.only(top: Constants.space8),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AutoSizeText.rich(
                    TextSpan(
                      text: '$secondaryLabel ',
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        SizedBox(height: marginBottom),
      ],
    );
  }
}
