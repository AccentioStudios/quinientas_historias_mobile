import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'outlined_card.dart';

class LeaderboardListItem extends StatelessWidget {
  const LeaderboardListItem({
    Key? key,
    required this.avatarWidget,
    required this.label,
    this.secondaryLabel,
    this.trailingWidget,
    this.onTap,
  }) : super(key: key);

  final Widget avatarWidget;
  final Widget label;
  final Widget? secondaryLabel;

  final Widget? trailingWidget;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.space16, vertical: Constants.space12),
      backgroundColor: brandBlue.withOpacity(0.08),
      border: Border.all(color: Colors.white.withOpacity(0.08)),
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: Constants.space16),
                child: SizedBox(width: 35, child: avatarWidget),
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label,
                    if (secondaryLabel != null) secondaryLabel!,
                  ],
                ),
              ),
              trailingWidget != null
                  ? trailingWidget!
                  : const SizedBox.shrink(),
            ],
          ),
        ],
      ),
    );
  }
}
