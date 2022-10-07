import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:quinientas_historias/core/ui/widgets/big_chip.dart';
import 'package:quinientas_historias/core/ui/widgets/padding_column.dart';
import 'package:quinientas_historias/core/ui/widgets/single_chip.dart';
import 'package:quinientas_historias/core/utils/constants.dart';
import 'package:quinientas_historias/features/profiles_module/school_profile/school_profile_provider.dart';

import '../../../../../core/data/entities/school_entity.dart';
import '../../../../../core/data/entities/team_entity.dart';
import '../../../../../core/integrations/remote_config_service.dart';
import '../../../../../core/routes/routes.dart';
import '../../../team_profile/team_profile_provider.dart';
import '../bloc/cubit/user_profile_cubit.dart';

class UserCards extends StatelessWidget {
  const UserCards({Key? key, required this.state}) : super(key: key);

  final UserProfileState state;

  @override
  Widget build(BuildContext context) {
    return PaddingColumn(
      padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: SingleChip(
                primaryLabel: state.user?.score.toString() ?? '0',
                secondaryLabel: 'Puntos totales',
                svgIconPath: 'assets/icons/points-outline-icon.svg',
              ),
            ),
            const SizedBox(width: Constants.space18),
            Expanded(
              child: SingleChip(
                primaryLabel: state.user?.readed.toString() ?? '0',
                secondaryLabel: 'Lecturas',
                svgIconPath: 'assets/icons/book-open-outline-icon.svg',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: Constants.space16,
        ),
        _UserPointsRowBottom(
          favoritos: state.user?.favoriteStories?.length ?? 0,
          streak: state.user?.streak ?? 0,
        ),
        const SizedBox(
          height: Constants.space16,
        ),
        Row(
          children: <Widget>[
            if (state.user?.team != null)
              _UserCard(
                onTap: () => _navigateToTeamPage(context, state.user?.team),
                label: state.isMyProfile ? 'Mi equipo' : 'Su equipo',
                content: state.user?.team?.name ?? '',
              ),
            if (state.user?.team != null)
              const SizedBox(
                width: Constants.space18,
              ),
            if (state.user?.school != null)
              _UserCard(
                onTap: () => _navigateToSchoolPage(context, state.user?.school),
                label: state.isMyProfile ? 'Mi escuela' : 'Su escuela',
                content: state.user?.school?.name ?? '',
              )
          ],
        ),
      ],
    );
  }

  void _navigateToTeamPage(BuildContext context, Team? team) {
    if (team != null) {
      Navigator.pushNamed(
        context,
        Routes.teamProfile,
        arguments: TeamProfileArguments(
          team.id,
        ),
      );
    }
  }

  void _navigateToSchoolPage(BuildContext context, School? school) {
    if (school != null) {
      Navigator.pushNamed(
        context,
        Routes.schoolProfile,
        arguments: SchoolProfileArguments(
          school.id,
        ),
      );
    }
  }
}

class _UserPointsRowBottom extends StatelessWidget {
  const _UserPointsRowBottom({
    Key? key,
    required this.favoritos,
    required this.streak,
  }) : super(key: key);

  final int favoritos;
  final int streak;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: SingleChip(
            primaryLabel: favoritos.toString(),
            secondaryLabel: 'Favoritos',
            svgIconPath: 'assets/icons/bookmark-outline-icon.svg',
          ),
        ),
        if (_checkUserStreakEnabled()) const SizedBox(width: Constants.space18),
        if (_checkUserStreakEnabled())
          Expanded(
              child: SingleChip(
            primaryLabel: streak.toString(),
            secondaryLabel: 'Racha actual',
            svgIconPath: 'assets/icons/flame-outline-icon.svg',
          ))
      ],
    );
  }

  bool _checkUserStreakEnabled() {
    final remoteConfig = RemoteConfigService.instance;
    final bool response = remoteConfig.getBool('user_streak_enabled');
    return response;
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({
    Key? key,
    required this.label,
    required this.content,
    this.onTap,
  }) : super(key: key);

  final String label;
  final String content;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BigChip(
        onTap: onTap,
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
                    color: Color.fromRGBO(182, 182, 182, 1),
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
