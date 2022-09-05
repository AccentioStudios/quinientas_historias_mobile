import 'package:flutter/material.dart';

import '../../data/entities/user_entity.dart';
import '../../utils/colors.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    required this.user,
    this.width = 42,
    this.height = 42,
  }) : super(key: key);

  final User user;
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
        border: Border.all(
            width: 2, color: getDivisionColor(user.division?.current.level)),
        shape: BoxShape.circle,
        image: user.avatarUrl != null
            ? DecorationImage(
                image: NetworkImage(user.avatarUrl!),
                fit: BoxFit.contain,
              )
            : null,
      ),
    );
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
