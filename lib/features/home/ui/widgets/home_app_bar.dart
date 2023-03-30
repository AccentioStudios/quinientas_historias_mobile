import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../core/ui/widgets/user_avatar.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constants.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    Key? key,
    this.user,
    this.onTap,
    this.hideStreak = false,
  }) : super(key: key);

  final User? user;
  final GestureTapCallback? onTap;
  final bool hideStreak;
  @override
  Widget build(BuildContext context) {
    const TextStyle userNameTextStyle =
        TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
    const TextStyle RoleTextStyle = TextStyle(fontSize: 14);

    return Container(
      width: double.infinity,
      height: 84,
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.space18, vertical: Constants.space21),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: onTap,
            child: _Username(
              userNameTextStyle: userNameTextStyle,
              RoleTextStyle: RoleTextStyle,
              user: user,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserStreak extends StatelessWidget with SheetMessages {
  const _UserStreak({
    Key? key,
    this.streakNumber = 0,
  }) : super(key: key);

  final int streakNumber;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showInfoAboutStreakMessage(context, streakNumber);
      },
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/flame-icon.svg',
            color: streakNumber > 0
                ? Theme.of(context).brightness == Brightness.light
                    ? streakFireRedColor
                    : streakFireRedDarkColor
                : Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          const SizedBox(width: Constants.space4),
          Text(
            streakNumber.toString(),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class _Username extends StatelessWidget {
  const _Username({
    Key? key,
    required this.userNameTextStyle,
    required this.RoleTextStyle,
    required this.user,
  }) : super(key: key);

  final TextStyle userNameTextStyle;
  final TextStyle RoleTextStyle;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        UserAvatar(
          user: user!,
        ),
        const SizedBox(width: Constants.space18),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${user?.firstName ?? ''} ${user?.lastName ?? ''}',
                style: userNameTextStyle),
            Text(formatRole(user?.role?.name), style: RoleTextStyle),
          ],
        ),
      ],
    );
  }

  String formatRole(Role? role) {
    switch (role) {
      case Role.reader:
        return 'Lector';
      case Role.prof:
        return 'Profesor';
      case Role.captain:
        return 'Capitan de Equipo';
      default:
        return '';
    }
  }
}
