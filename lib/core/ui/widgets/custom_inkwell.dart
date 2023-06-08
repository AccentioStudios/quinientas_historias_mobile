import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    super.key,
    this.backgroundColor,
    this.splashColor,
    this.borderRadius,
    this.onTap,
    this.selected = false,
    required this.child,
  });

  final Color? backgroundColor;
  final Color? splashColor;
  final BorderRadius? borderRadius;
  final GestureTapCallback? onTap;
  final bool selected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor =
        this.backgroundColor ?? Theme.of(context).colorScheme.primaryContainer;
    Color splashColor =
        this.splashColor ?? Theme.of(context).colorScheme.secondary;

    return Material(
      color: selected ? splashColor : backgroundColor,
      borderRadius: borderRadius ?? Constants.borderRadius18,
      child: InkWell(
        borderRadius: borderRadius ?? Constants.borderRadius18,
        onTap: onTap,
        splashColor: selected ? splashColor.withBlue(80) : splashColor,
        child: child,
      ),
    );
  }
}
