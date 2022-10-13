import 'package:flutter/material.dart';

import '../../../../../core/data/entities/team_entity.dart';
import '../../../../../core/ui/widgets/group_avatar.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/team_profile_cubit.dart';

class TeamProfileHeader extends StatelessWidget {
  const TeamProfileHeader({Key? key, required this.state}) : super(key: key);

  final TeamProfileState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaddingColumn(
          padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
          children: [
            const SizedBox(height: Constants.space21),
            TeamProfileAvatar(
              team: state.team,
            ),
            const SizedBox(height: Constants.space21),
            Align(
              alignment: Alignment.center,
              child: Text(
                state.team?.name ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TeamProfileAvatar extends StatelessWidget {
  const TeamProfileAvatar({Key? key, required this.team}) : super(key: key);
  final Team? team;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: GroupAvatar(
            avatarUrl: team?.avatarUrl,
            type: GroupAvatarType.team,
          ),
        ),
      ],
    );
  }
}
