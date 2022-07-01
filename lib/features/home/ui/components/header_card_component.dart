import 'package:flutter/material.dart';
import 'package:quinientas_historias/core/data/entities/daily_challenge_entity.dart';

import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/data/entities/story_progress_entity.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/ui/widgets/single_chip.dart';
import '../../../../core/utils/constants.dart';
import '../../../reading_module/daily_challenge/daily_challange_provider.dart';
import '../../../reading_module/data/models/author_model.dart';
import '../../bloc/cubit/home_cubit.dart';
import '../widgets/hero_header_widget.dart';
import '../widgets/home_app_bar.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({
    Key? key,
    required this.state,
  }) : super(key: key);
  final HomeState state;
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
        HomeAppBar(user: state.user),
        PaddingColumn(
          padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
          children: [
            const SizedBox(height: Constants.space12),
            HeroHeader(
              dayState: HeroHeaderDayState.day,
              onTap: () => _navigateToDailyChallenge(context),
              dailyChallenge: state.dailyChallenge,
            ),
            const SizedBox(height: Constants.space18),
            _PointsRow(
              points: state.user?.score ?? 0,
              favorites: state.user?.favoriteStories.length ?? 0,
            )
          ],
        ),
      ]),
    );
  }

  void _navigateToDailyChallenge(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const DailyChallangeProvider()));
  }
}

class _PointsRow extends StatelessWidget {
  const _PointsRow({
    Key? key,
    required this.points,
    required this.favorites,
  }) : super(key: key);

  final int points;
  final int favorites;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SingleChip(
            primaryLabel: points.toString(),
            secondaryLabel: 'Puntos totales',
            svgIconPath: 'assets/icons/points-icon.svg',
          ),
        ),
        const SizedBox(width: Constants.space18),
        Expanded(
          child: SingleChip(
            primaryLabel: favorites.toString(),
            secondaryLabel: 'Favoritos',
            svgIconPath: 'assets/icons/bookmark-icon.svg',
          ),
        ),
      ],
    );
  }
}
