import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class BigButton extends StatelessWidget {
  const BigButton({
    super.key,
    required this.onPressed,
    this.child,
    this.text,
    this.isLoading = false,
    this.elevation = 0,
    this.fontSize = 18,
    this.padding = const EdgeInsets.symmetric(
        horizontal: Constants.space21, vertical: Constants.space16),
    this.svgIconPath,
    this.filled = true,
    // this.width,
    // this.height,
  });
  final void Function()? onPressed;
  final Widget? child;
  final String? text;
  final bool isLoading;
  final double? elevation;
  final double? fontSize;
  final EdgeInsets padding;
  final String? svgIconPath;
  final bool filled;
  // final double? width;
  // final double? height;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(foregroundColor:
          MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          if (Theme.of(context).brightness == Brightness.dark) {
            return onPrimaryMutedDarkColor;
          }
          return onPrimaryMutedColor;
        }
        return null;
      }), backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            if (Theme.of(context).brightness == Brightness.dark) {
              return primaryMutedDarkColor;
            }
            if (filled) {
              return primaryMutedColor;
            }
            return Colors.transparent;
          }
          if (filled) {
            return Theme.of(context).colorScheme.primary;
          }
          return Colors.transparent;
        },
      ), shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((_) {
        return RoundedRectangleBorder(
          borderRadius: Constants.borderRadius50,
        );
      }), elevation: MaterialStateProperty.resolveWith<double?>((_) {
        return filled ? elevation : 0;
      })),
      onPressed: isLoading ? null : onPressed,
      child: Padding(
        padding: padding,
        child: SizedBox(
          height: 24,
          child: isLoading
              ? buildProgressIndicator(context)
              : text != null
                  ? svgIconPath != null
                      ? buildTextWithIconOption(context)
                      : buildTextOption(context)
                  : child,
        ),
      ),
    );
  }

  Center buildProgressIndicator(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 21,
      width: 21,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    ));
  }

  Widget buildTextOption(BuildContext context) {
    return Center(
      child: AutoSizeText(
        text ?? '',
        style: TextStyle(
          color: getEnabledTextColor(context, onPressed != null),
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color getEnabledTextColor(BuildContext context, bool enabled) {
    if (enabled) {
      if (Theme.of(context).brightness == Brightness.dark) {
        return filled ? onPrimaryDarkColor : primaryDarkColor;
      } else {
        return filled ? onPrimaryColor : onPrimaryColor;
      }
    } else {
      if (Theme.of(context).brightness == Brightness.dark) {
        return onPrimaryMutedDarkColor;
      } else {
        return onPrimaryMutedColor;
      }
    }
  }

  Widget buildTextWithIconOption(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(
            svgIconPath!,
            color: getEnabledTextColor(context, onPressed != null),
          ),
        ),
        Flexible(child: buildTextOption(context)),
      ]),
    );
  }
}
