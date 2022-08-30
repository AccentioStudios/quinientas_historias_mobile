import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';
import 'package:quinientas_historias/core/ui/widgets/outlined_card.dart';
import 'package:quinientas_historias/core/ui/widgets/padding_column.dart';
import 'package:quinientas_historias/core/ui/widgets/percentage_progress_bar.dart';
import 'package:quinientas_historias/features/profiles_module/user_profile/ui/pages/user_progress_page.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/widgets/user_avatar.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constants.dart';
import '../../user_profile_provider.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    const TextStyle userNameProfileTextStyle =
        (TextStyle(fontSize: 24, fontWeight: FontWeight.bold));

    return Column(
      children: <Widget>[
        AppBar(
          elevation: 0,
          centerTitle: false,
          toolbarHeight: 64,
          actions: [
            IconButton(
              iconSize: 24,
              onPressed: () {},
              icon: const Icon(Icons.edit_outlined),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text("Editar perfil"),
            )
          ],
        ),
        _UserProfile(
            userNameProfileTextStyle: userNameProfileTextStyle, user: user),
        const Padding(
          padding: EdgeInsets.only(bottom: Constants.space41),
        ),
        _UserDivision(
          user: user,
        ),
      ],
    );
  }
}

class _UserProfile extends StatelessWidget {
  const _UserProfile(
      {Key? key, required this.userNameProfileTextStyle, required this.user})
      : super(key: key);

  final TextStyle userNameProfileTextStyle;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(Constants.space18),
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: <Widget>[
              UserAvatar(
                user: user!,
                width: 140,
                height: 140,
              ),
              const CircleAvatar(
                backgroundColor: Color(0xff385775),
                radius: 18.5,
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 22.5,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(user!.firstName ?? '', style: userNameProfileTextStyle),
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
    return Padding(
      padding: const EdgeInsets.only(
          right: Constants.space16, left: Constants.space21),
      child: OutlinedCard(
        child: PaddingColumn(
          padding: const EdgeInsets.all(Constants.space4),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Text('Mi nivel: ',
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                SvgPicture.asset(
                  getDivisionBadge(user?.division?.level),
                  height: 30,
                  width: 30,
                ),
                Text(getDivisionName(user?.division?.level)),
              ],
            ),
            Row(
              children: <Widget>[
                Flexible(
                    child: PercentageProgressBar(
                  backgroundColor: getDivisionColor(user!.division?.level),
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
      ),
    );
  }

  int getPointsLeft(User user) {
    return (user.division!.scoreToAchieve! - user.score!);
  }

  int getPercentageCompleted(User user) {
    return ((user.score! / user.division!.scoreToAchieve!) * 100).toInt();
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
