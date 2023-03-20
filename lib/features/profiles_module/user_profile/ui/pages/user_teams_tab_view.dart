import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';

import '../../../../../core/data/dto/user_profile_dto.dart';
import '../../../../../core/data/entities/team_entity.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/widgets/group_avatar.dart';
import '../../../../../core/ui/widgets/outlined_card.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constants.dart';
import '../../../team_profile/team_profile_provider.dart';

class UserTeamsTabView extends StatelessWidget {
  const UserTeamsTabView({super.key, required this.user});

  final UserProfileDto user;

  @override
  Widget build(BuildContext context) {
    return user.team != null
        ? SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.space18, vertical: 0),
              child: Column(
                children: [
                  ProfileTeamCard(
                    user: user,
                    team: user.team!,
                    userTeamPoints: user.userTeamPoints,
                    userTeamRank: user.userTeamRank,
                    onTap: () {
                      _navigateToTeamPage(context, user.team!);
                    },
                  ),
                  const SizedBox(height: Constants.space30),
                  const Text('Anteriores torneos'),
                  const SizedBox(height: Constants.space21),

                  // ...user.teams.map(
                  //   (team) => ProfileTeamCard(
                  //     user: user,
                  //     team: team,
                  //     onTap: () {
                  //       // _navigateToStoryPage(context, favorite);
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        : const UserTeamsEmptyState();
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
}

class ProfileTeamCard extends StatelessWidget {
  const ProfileTeamCard(
      {super.key,
      required this.team,
      required this.user,
      required this.userTeamPoints,
      required this.userTeamRank,
      required this.onTap,
      this.isLive = false});

  final UserProfileDto user;
  final Team team;
  final int userTeamPoints;
  final int userTeamRank;
  final Function() onTap;
  final bool isLive;

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.space16, vertical: Constants.space12),
      backgroundColor: brandBlue.withOpacity(0.08),
      border: Border.all(color: Colors.white.withOpacity(0.08)),
      child: Column(children: [
        Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: Constants.space16),
                    child: SizedBox(
                      width: 35,
                      child: GroupAvatar(
                        avatarUrl: team.avatarUrl,
                        type: GroupAvatarType.team,
                      ),
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText.rich(
                      style: DefaultTextStyle.of(context)
                          .style
                          .copyWith(fontSize: 14),
                      TextSpan(text: team.name),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 20,
              height: 20,
              child: RiveAnimation.asset(
                  'assets/images/live-indicator-animation.riv'),
            )
          ],
        ),
        const SizedBox(height: Constants.space12),
        Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText.rich(
                TextSpan(
                  style:
                      DefaultTextStyle.of(context).style.copyWith(fontSize: 13),
                  children: <TextSpan>[
                    TextSpan(
                      text: '$userTeamPoints ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const TextSpan(text: 'puntos    '),
                    TextSpan(
                      text: '$userTeamRank ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    TextSpan(text: 'posición'),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ]),
      ]),
    );
  }
}

class UserTeamsEmptyState extends StatelessWidget {
  const UserTeamsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset('assets/icons/trophy-outline-icon.svg'),
            ),
            const SizedBox(height: Constants.space21),
            const Text('No hay equipos todavía'),
            const SizedBox(height: Constants.space41),
          ]),
    );
  }
}
