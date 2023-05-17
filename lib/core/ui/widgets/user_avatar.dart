import 'package:flutter/material.dart';
import 'package:quinientas_historias/core/data/entities/user_division_entity.dart';

import '../../data/entities/user_entity.dart';
import '../../utils/colors.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.user,
    this.userDivision,
    this.avatarUrl,
    this.width = 42,
    this.height = 42,
  });

  final User? user;
  final UserDivision? userDivision;
  final String? avatarUrl;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: const BoxConstraints(
        minHeight: 12,
        minWidth: 12,
        maxWidth: 140,
        maxHeight: 140,
      ),
      decoration: BoxDecoration(
        border:
            user?.role?.name == Role.reader || user?.role?.name == Role.captain
                ? Border.all(
                    width: 2,
                    color: getDivisionColor(userDivision?.current?.level))
                : null,
        shape: BoxShape.circle,
        image: getAvatarUrl() != null && getAvatarUrl() != ""
            ? DecorationImage(
                image: NetworkImage(getAvatarUrl()!),
                fit: BoxFit.contain,
              )
            : const DecorationImage(
                image: AssetImage(
                    'assets/images/avatar-user-placeholder-image.jpg'),
                fit: BoxFit.contain,
              ),
      ),
    );
  }

  String? getAvatarUrl() {
    if (user != null) {
      if (user!.avatarUrl != null) return user!.avatarUrl!;
    }
    if (avatarUrl != null) return avatarUrl!;
    return null;
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
