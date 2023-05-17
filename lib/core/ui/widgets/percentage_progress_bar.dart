import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class PercentageProgressBar extends StatelessWidget {
  const PercentageProgressBar({
    super.key,
    this.completedPercentage = 0,
    this.backgroundColor,
  });
  final int completedPercentage;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: Constants.borderRadius16,
          child: LinearProgressIndicator(
            minHeight: 7,
            value: completedPercentage / 100,
            backgroundColor: backgroundColor != null
                ? backgroundColor!.withOpacity(0.32)
                : Theme.of(context)
                    .colorScheme
                    .secondaryContainer
                    .withOpacity(0.32),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
