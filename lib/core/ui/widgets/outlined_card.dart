import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class OutlinedCard extends StatelessWidget {
  const OutlinedCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.border,
    this.borderRadius,
    this.backgroundColor,
  });
  final Widget child;
  final EdgeInsets? padding;
  final GestureTapCallback? onTap;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius ?? Constants.borderRadius18,
          border: border ?? Border.all(color: Colors.white.withOpacity(0.20))),
      child: InkWell(
        onTap: onTap,
        borderRadius: Constants.borderRadius18,
        child: Padding(
            padding: padding ??
                const EdgeInsets.symmetric(
                    horizontal: Constants.space12, vertical: Constants.space12),
            child: child),
      ),
    );
  }
}
