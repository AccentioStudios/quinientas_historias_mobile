import 'package:flutter/material.dart';

import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/ui/widgets/single_chip.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/cubit/home_cubit.dart';
import '../widgets/hero_header_widget.dart';
import '../widgets/home_app_bar.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({
    Key? key,
    required this.state,
    required this.userProfileOnTap,
    required this.dailyChallengeOnTap,
  }) : super(key: key);
  final HomeState state;
  final GestureTapCallback? userProfileOnTap;
  final GestureTapCallback? dailyChallengeOnTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 290 + MediaQuery.of(context).padding.top,
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(children: [
        HomeAppBar(
          user: state.dashboard?.user,
          onTap: userProfileOnTap,
        ),
        PaddingColumn(
          padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
          children: [
            const SizedBox(height: Constants.space12),
            HeroHeader(
              dayState: getHeroHeaderState(),
              onTap: dailyChallengeOnTap,
              dailyChallenge: state.dashboard?.dailyChallenge,
            ),
            const SizedBox(height: Constants.space18),
            _PointsRow(
              points: state.dashboard?.user.score ?? 0,
              readed: state.dashboard?.user.readed ?? 0,
            )
          ],
        ),
      ]),
    );
  }

  HeroHeaderDayState getHeroHeaderState() {
    var hour = DateTime.now().hour;

    if (hour >= 07 && hour <= 14) {
      return HeroHeaderDayState.day;
    }
    if (hour > 14 && hour <= 19) {
      return HeroHeaderDayState.afternoon;
    }
    return HeroHeaderDayState.night;
  }
}

class _PointsRow extends StatelessWidget {
  const _PointsRow({
    Key? key,
    required this.points,
    required this.readed,
  }) : super(key: key);

  final int points;
  final int readed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: SingleChip(
            primaryLabel: points.toString(),
            secondaryLabel: 'Puntos totales',
            svgIconPath: 'assets/icons/points-icon.svg',
          ),
        ),
        const SizedBox(width: Constants.space18),
        Expanded(
          flex: 1,
          child: SingleChip(
            primaryLabel: readed.toString(),
            secondaryLabel: 'Lecturas totales',
            svgIconPath: 'assets/icons/book-open-icon.svg',
          ),
        ),
      ],
    );
  }
}
