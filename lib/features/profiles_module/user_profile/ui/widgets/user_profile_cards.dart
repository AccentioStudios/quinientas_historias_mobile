import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:quinientas_historias/core/ui/widgets/big_chip.dart';
import 'package:quinientas_historias/core/ui/widgets/padding_column.dart';
import 'package:quinientas_historias/core/ui/widgets/single_chip.dart';
import 'package:quinientas_historias/core/utils/constants.dart';

import '../bloc/cubit/user_profile_cubit.dart';

class UserCards extends StatelessWidget {
  const UserCards({Key? key, required this.state}) : super(key: key);

  final UserProfileState state;

  @override
  Widget build(BuildContext context) {
    return PaddingColumn(
      padding: const EdgeInsets.all(Constants.space16),
      children: <Widget>[
        _UserPointsRowTop(
          points: state.user?.score ?? 0,
          favorites: state.user?.favoriteStories?.length ?? 0,
        ),
        const SizedBox(
          height: Constants.space16,
        ),
        Row(
          children: <Widget>[
            _UserTeamsCard(
              label: 'Mi equipo',
              content: state.user?.team?.name ?? '',
            ),
            const SizedBox(
              width: Constants.space18,
            ),
            _UserTeamsCard(
              label: 'Mi escuela',
              content: state.user?.school?.name ?? '',
            )
          ],
        ),
        const SizedBox(
          height: Constants.space16,
        ),
        _UserPointsRowBottom(
          reads: state.user?.readed ?? 0,
          streak: state.user?.streak ?? 0,
        )
      ],
    );
  }
}

class _UserPointsRowTop extends StatelessWidget {
  const _UserPointsRowTop({
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
            svgIconPath: 'assets/icons/points-outline-icon.svg',
          ),
        ),
        const SizedBox(width: Constants.space18),
        Expanded(
            child: SingleChip(
          primaryLabel: favorites.toString(),
          secondaryLabel: 'Favoritos',
          svgIconPath: 'assets/icons/bookmark-outline-icon.svg',
        ))
      ],
    );
  }
}

class _UserPointsRowBottom extends StatelessWidget {
  const _UserPointsRowBottom({
    Key? key,
    required this.reads,
    required this.streak,
  }) : super(key: key);

  final int reads;
  final int streak;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SingleChip(
            primaryLabel: reads.toString(),
            secondaryLabel: 'Lecturas Totales',
            svgIconPath: 'assets/icons/book-open-outline-icon.svg',
          ),
        ),
        const SizedBox(width: Constants.space18),
        Expanded(
            child: SingleChip(
          primaryLabel: streak.toString(),
          secondaryLabel: 'Racha actual',
          svgIconPath: 'assets/icons/flame-outline-icon.svg',
        ))
      ],
    );
  }
}

class _UserTeamsCard extends StatelessWidget {
  const _UserTeamsCard({
    Key? key,
    required this.label,
    required this.content,
  }) : super(key: key);

  final String label;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BigChip(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.space16, vertical: Constants.space16),
        primary: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        secondary: Padding(
          padding: const EdgeInsets.only(top: Constants.space8),
          child: SizedBox(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                AutoSizeText(
                  content,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: const Color.fromRGBO(182, 182, 182, 1),
                  ),
                  minFontSize: 14,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
