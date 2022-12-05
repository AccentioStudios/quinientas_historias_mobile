import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/ui/widgets/outlined_card.dart';
import '../../../../../core/ui/widgets/percentage_progress_bar.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/user_profile_cubit.dart';

class UserDivisionCard extends StatelessWidget {
  const UserDivisionCard({
    Key? key,
    required this.state,
  }) : super(key: key);

  final UserProfileState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
      child: OutlinedCard(
        onTap: () {},
        padding: const EdgeInsets.only(
          left: Constants.space16,
          right: Constants.space16,
          bottom: Constants.space16,
          top: Constants.space12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(state.isMyProfile ? 'Mi nivel: ' : 'Su nivel: ',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold)),
                SvgPicture.asset(
                  getDivisionBadge(state.user?.division?.current.level),
                  height: 30,
                  width: 30,
                ),
                Text(getDivisionName(state.user?.division?.current.level)),
              ],
            ),
            Row(
              children: <Widget>[
                Flexible(
                    child: PercentageProgressBar(
                  backgroundColor:
                      getDivisionColor(state.user!.division?.current.level),
                  completedPercentage: getPercentageCompleted(state.user!),
                )),
                Padding(
                  padding: const EdgeInsets.only(left: Constants.space8),
                  child: Text('${getPercentageCompleted(state.user!)}%'),
                )
              ],
            ),
            const SizedBox(
              height: Constants.space8,
            ),
            Text(
              '${state.isMyProfile ? 'Te' : 'Le'} faltan ${getPointsLeft(state.user!)} puntos para llegar al siguiente nivel',
              style: const TextStyle(fontSize: 13),
            )
          ],
        ),
      ),
    );
  }

  int getPointsLeft(User user) {
    if (user.division!.next != null) {
      return (user.division!.next!.scoreToAchieve - user.score!);
    }
    return 0;
  }

  int getPercentageCompleted(User user) {
    if (user.division!.next != null) {
      return ((user.score! / user.division!.next!.scoreToAchieve) * 100)
          .toInt();
    }
    return 100;
  }

  String getDivisionBadge(int? level) {
    if (level == 1) {
      return 'assets/icons/division-1-badge.svg';
    }
    if (level == 2) {
      return 'assets/icons/division-2-badge.svg';
    }
    if (level == 3) {
      return 'assets/icons/division-3-badge.svg';
    }
    if (level == 4) {
      return 'assets/icons/division-4-badge.svg';
    }
    if (level == 5) {
      return 'assets/icons/division-5-badge.svg';
    }
    return '';
  }

  String getDivisionName(int? level) {
    if (level == 1) {
      return 'Iniciante';
    }
    if (level == 2) {
      return 'Entusiasta';
    }
    if (level == 3) {
      return 'Dedicado';
    }
    if (level == 4) {
      return 'Lector Defnitivo';
    }
    if (level == 5) {
      return 'Maestro';
    }
    return '';
  }

  Color getDivisionColor(int? level) {
    if (level == 1) {
      return division1Color;
    }
    if (level == 2) {
      return division2Color;
    }
    if (level == 3) {
      return division3Color;
    }
    if (level == 4) {
      return division4Color;
    }
    if (level == 5) {
      return division5Color;
    }

    return Colors.transparent;
  }
}
