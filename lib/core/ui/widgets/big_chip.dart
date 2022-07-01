import 'package:flutter/material.dart';
import 'package:quinientas_historias/core/ui/widgets/outlined_card.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';

class BigChip extends StatelessWidget {
  const BigChip({
    Key? key,
    this.primary,
    this.primaryLabel,
    this.secondary,
    this.secondaryLabel,
    this.padding,
    this.onTap,
  }) : super(key: key);
  final Widget? primary;
  final String? primaryLabel;
  final Widget? secondary;
  final String? secondaryLabel;
  final EdgeInsets? padding;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      onTap: onTap,
      padding: padding ??
          const EdgeInsets.symmetric(
              horizontal: Constants.space12, vertical: Constants.space12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        primaryLabel != null
            ? Text(primaryLabel!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16, height: 1))
            : primary!,
        secondaryLabel != null
            ? Text(secondaryLabel!,
                style: const TextStyle(
                    fontSize: 14, color: onSurfaceMutedTextDarkColor))
            : secondary!,
      ]),
    );
  }
}
