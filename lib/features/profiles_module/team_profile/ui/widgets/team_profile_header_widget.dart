import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/data/entities/team_entity.dart';
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
              canEdit: state.canEdit,
              editOnPressed: () {},
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
  const TeamProfileAvatar(
      {Key? key,
      required this.team,
      required this.canEdit,
      required this.editOnPressed})
      : super(key: key);
  final Team? team;
  final bool canEdit;
  final void Function()? editOnPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: CircleAvatar(
            radius: 68,
            backgroundImage: NetworkImage(team?.avatarUrl ?? ''),
          ),
        ),
        if (canEdit == true)
          Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff385775)),
              child: IconButton(
                  onPressed: editOnPressed,
                  icon: Center(
                    child: SvgPicture.asset(
                        'assets/icons/camera-outline-icon.svg'),
                  ))),
      ],
    );
  }
}
