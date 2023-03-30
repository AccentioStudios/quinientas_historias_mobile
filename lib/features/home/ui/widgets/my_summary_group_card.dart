import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quinientas_historias/features/profiles_module/school_profile/school_profile_provider.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/ui/widgets/group_avatar.dart';
import '../../../../core/ui/widgets/outlined_card.dart';
import '../../../../core/utils/constants.dart';
import '../../../profiles_module/team_profile/team_profile_provider.dart';

class MySummaryGroupCard extends StatelessWidget {
  const MySummaryGroupCard({
    super.key,
    required this.type,
    required this.groupId,
    this.avatarUrl,
    this.groupName,
    this.userPoints,
    this.userReads,
    this.rankPlace,
  });

  final GroupAvatarType type;
  final int groupId;
  final String? avatarUrl;
  final String? groupName;
  final int? userPoints;
  final int? userReads;
  final int? rankPlace;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 277,
      height: 130,
      child: OutlinedCard(
          onTap: () {
            if (type == GroupAvatarType.team) {
              _navigateToTeamPage(context, groupId);
            }
            if (type == GroupAvatarType.school) {
              _navigateToSchoolPage(context, groupId);
            }
          },
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.space18, vertical: Constants.space18),
          child: Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: Constants.space12),
                    child: GroupAvatar(
                      type: type,
                      avatarUrl: avatarUrl,
                    ),
                  ),
                  Expanded(
                    child: AutoSizeText.rich(
                      TextSpan(
                        style: DefaultTextStyle.of(context)
                            .style
                            .copyWith(fontSize: 15),
                        text: groupName,
                      ),
                      maxLines: 2,
                      minFontSize: 13,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: AutoSizeText.rich(
                      TextSpan(
                        style: DefaultTextStyle.of(context)
                            .style
                            .copyWith(fontSize: 14),
                        children: <TextSpan>[
                          if (userPoints != null)
                            TextSpan(
                              text: '$userPoints ',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold),
                            ),
                          if (userPoints != null)
                            const TextSpan(text: ' puntos  '),
                          if (userReads != null)
                            TextSpan(
                              text: '$userReads ',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          if (userReads != null)
                            const TextSpan(text: ' leídos'),
                        ],
                      ),
                      maxLines: 1,
                      maxFontSize: 14,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (rankPlace != null)
                    Text(
                      "#$rankPlace",
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    )
                ],
              )
            ],
          )),
    );
  }

  void _navigateToTeamPage(BuildContext context, int teamId) {
    Navigator.pushNamed(
      context,
      Routes.teamProfile,
      arguments: TeamProfileArguments(
        teamId,
      ),
    );
  }

  void _navigateToSchoolPage(BuildContext context, int schoolId) {
    Navigator.pushNamed(
      context,
      Routes.schoolProfile,
      arguments: SchoolProfileArguments(schoolId),
    );
  }
}
