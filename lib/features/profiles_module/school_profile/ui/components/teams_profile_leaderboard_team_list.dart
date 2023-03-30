import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quinientas_historias/core/mixins/error_handling.dart';
import 'package:quinientas_historias/core/ui/widgets/group_avatar.dart';

import '../../../../../core/data/entities/leaderboard_entity.dart';
import '../../../../../core/data/entities/team_entity.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/leaderboard_list_item_widget.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/utils/constants.dart';
import '../../../team_profile/team_profile_provider.dart';
import '../bloc/cubit/school_profile_cubit.dart';

class TeamsProfileLeaderboardTeamList extends StatelessWidget
    with ErrorHandling {
  const TeamsProfileLeaderboardTeamList({Key? key, required this.state})
      : super(key: key);

  final SchoolProfileState state;

  @override
  Widget build(BuildContext context) {
    final List<Leaderboard>? list = state.school?.leaderboard;
    return PaddingColumn(
      padding: const EdgeInsets.only(
          left: Constants.space16,
          right: Constants.space16,
          bottom: Constants.space41),
      children: [
        const Headline(
          marginTop: Constants.space41,
          label: 'Tablero de posiciones de la escuela',
        ),
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: Constants.space12),
          itemCount: list?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return LeaderboardListItem(
              onTap: () => navigateToTeamProfile(context, list?[index].team),
              avatarWidget: GroupAvatar(
                avatarUrl: list?[index].team?.avatarUrl,
                type: GroupAvatarType.team,
              ),
              label: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: AutoSizeText.rich(
                      TextSpan(
                        style: DefaultTextStyle.of(context)
                            .style
                            .copyWith(fontSize: 15),
                        children: <TextSpan>[
                          TextSpan(
                            text: '#${list?[index].rankPlace} ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: '${list?[index].team?.name}'),
                        ],
                      ),
                      maxLines: 1,
                      minFontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              secondaryLabel: RichText(
                text: TextSpan(
                  style:
                      DefaultTextStyle.of(context).style.copyWith(fontSize: 15),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${list?[index].userPoints} ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    const TextSpan(text: 'puntos'),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  navigateToTeamProfile(BuildContext context, Team? team) {
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
