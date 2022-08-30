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
      backgroundColor: brandBlue.withOpacity(0.08),
      border: Border.all(color: Colors.white.withOpacity(0.08)),
      child: Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(.08),
        child: Flex(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: [
            Flex(
              direction: Axis.horizontal,
              children: [
                SizedBox(width: 35, child: avatarWidget),
                const SizedBox(width: Constants.space12),
                Flex(
                  direction: Axis.vertical,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    label,
                    secondaryLabel != null
                        ? secondaryLabel!
                        : const SizedBox.shrink(),
                  ],
                ),
              ],
            ),
            trailingWidget != null ? trailingWidget! : const SizedBox.shrink(),
          ],
        ),
      ),
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
