import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';
import 'package:quinientas_historias/core/ui/widgets/outlined_card.dart';
import 'package:quinientas_historias/core/ui/widgets/padding_column.dart';
import 'package:quinientas_historias/core/ui/widgets/percentage_progress_bar.dart';

import '../../../../../core/ui/widgets/user_avatar.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constants.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    const TextStyle userNameProfileTextStyle =
        (TextStyle(fontSize: 24, fontWeight: FontWeight.bold));

    return PaddingColumn(
      padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
      children: <Widget>[
        _UserProfileAvatar(user: user),
        const SizedBox(height: Constants.space18),
        Text(user!.firstName ?? '', style: userNameProfileTextStyle),
        const SizedBox(height: Constants.space41),
        _UserDivision(
          user: user,
        ),
      ],
    );
  }
}

class _UserProfileAvatar extends StatelessWidget {
  const _UserProfileAvatar({Key? key, required this.user}) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            UserAvatar(
              user: user!,
              width: 140,
              height: 140,
            ),
            CircleAvatar(
                backgroundColor: const Color(0xff385775),
                radius: 18.5,
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 22.5,
                      color: Colors.white,
                    ))),
          ],
        ),
      ],
    );
  }
}

class _UserDivision extends StatelessWidget {
  const _UserDivision({
    Key? key,
    this.user,
  }) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return OutlinedCard(
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
              const Text('Mi nivel: ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              SvgPicture.asset(
                getDivisionBadge(user?.division?.current.level),
                height: 30,
                width: 30,
              ),
              Text(getDivisionName(user?.division?.current.level)),
            ],
          ),
          Row(
            children: <Widget>[
              Flexible(
                  child: PercentageProgressBar(
                backgroundColor:
                    getDivisionColor(user!.division?.current.level),
                completedPercentage: getPercentageCompleted(user!),
              )),
              Padding(
                padding: const EdgeInsets.only(left: Constants.space8),
                child: Text('${getPercentageCompleted(user!)}%'),
              )
            ],
          ),
          const SizedBox(
            height: Constants.space8,
          ),
          Text(
            'Te faltan ${getPointsLeft(user!)} puntos para llegar al siguiente nivel',
            style: const TextStyle(fontSize: 13),
          )
        ],
      ),
    );
  }

  int getPointsLeft(User user) {
    return (user.division!.next.scoreToAchieve - user.score!);
  }

  int getPercentageCompleted(User user) {
    return ((user.score! / user.division!.next.scoreToAchieve) * 100).toInt();
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
