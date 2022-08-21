import 'package:flutter/material.dart';

import '../../../../core/data/models/leaderboard_model.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constants.dart';
import 'tournament_arrow_position_widget.dart';

class LeaderboardListItem extends StatelessWidget {
  const LeaderboardListItem({
    Key? key,
    required this.avatarWidget,
    required this.label,
    this.secondaryLabel,
    this.trailingWidget,
  }) : super(key: key);

  final Widget avatarWidget;
  final Widget label;
  final Widget? secondaryLabel;

  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.space16, vertical: Constants.space12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer.withOpacity(.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(.08),
        ),
      ),
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
