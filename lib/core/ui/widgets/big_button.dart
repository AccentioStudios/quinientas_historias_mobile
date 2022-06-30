import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class BigButton extends StatelessWidget {
  const BigButton(
      {Key? key,
      required this.onPressed,
      this.child,
      this.text,
      this.isLoading = false,
      this.elevation = 0,
      this.fontSize = 18,
      this.padding = const EdgeInsets.symmetric(
          horizontal: Constants.space21, vertical: Constants.space16),
      this.svgIconPath
      // this.width,
      // this.height,
      })
      : super(key: key);
  final void Function()? onPressed;
  final Widget? child;
  final String? text;
  final bool isLoading;
  final double? elevation;
  final double? fontSize;
  final EdgeInsets padding;
  final String? svgIconPath;
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
            return primaryMutedColor;
          }
          return null;
        },
      ), shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((_) {
        return RoundedRectangleBorder(
          borderRadius: Constants.borderRadius50,
        );
      }), elevation: MaterialStateProperty.resolveWith<double?>((_) {
        return elevation;
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
                      : buildTextOption()
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

  Widget buildTextOption() {
    return Center(
      child: Text(
        text ?? '',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildTextWithIconOption(BuildContext context) {
    return Center(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(
            svgIconPath!,
            color: onPressed != null
                ? Theme.of(context).brightness == Brightness.dark
                    ? onPrimaryDarkColor
                    : onPrimaryColor
                : Theme.of(context).brightness == Brightness.dark
                    ? onPrimaryMutedDarkColor
                    : onPrimaryMutedColor,
          ),
        ),
        Flexible(child: buildTextOption()),
      ]),
    );
  }
}
