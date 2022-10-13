import 'package:flutter/material.dart';

import '../../data/models/leaderboard_model.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../../features/tournament/ui/widgets/tournament_arrow_position_widget.dart';
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
      // child: Container(
      //   width: double.infinity,
      //   color: Theme.of(context).colorScheme.primaryContainer.withOpacity(.08),
      //   child: Flex(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     direction: Axis.horizontal,
      //     children: [
      //       Flex(
      //         direction: Axis.horizontal,
      //         children: [
      //           // Flexible(child: SizedBox(width: 35, child: avatarWidget)),

      //           Flexible(
      //             child: Column(
      //               mainAxisSize: MainAxisSize.max,
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: <Widget>[
      //                 label,
      //                 secondaryLabel != null
      //                     ? secondaryLabel!
      //                     : const SizedBox.shrink(),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //       trailingWidget != null ? trailingWidget! : const SizedBox.shrink(),
      //     ],
      //   ),
      // ),
    );
  }
}

class TournamentPositionArrow extends StatelessWidget {
  const TournamentPositionArrow(
      {Key? key, required this.number, required this.arrowPositionDirection})
      : super(key: key);
  final int number;
  final LeaderboardChangePositionType arrowPositionDirection;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          number.toString(),
          style: TextStyle(color: buildColor(context, arrowPositionDirection)),
        ),
        ArrowPosition(
          arrowPositionDirection: arrowPositionDirection,
        )
      ],
    );
  }

  Color buildColor(BuildContext context,
      LeaderboardChangePositionType arrowPositionDirection) {
    final lightTheme = Theme.of(context).brightness == Brightness.light;
    switch (arrowPositionDirection) {
      case LeaderboardChangePositionType.positive:
        return lightTheme ? successColor : successDarkColor;
      case LeaderboardChangePositionType.negative:
        return lightTheme ? errorColor : errorDarkColor;
      case LeaderboardChangePositionType.neutral:
        return lightTheme ? onSurfaceVariantColor : onSurfaceVariantDarkColor;
    }
  }
}
