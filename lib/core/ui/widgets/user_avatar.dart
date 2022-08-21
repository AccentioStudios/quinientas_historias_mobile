import 'package:flutter/material.dart';

import '../../data/entities/user_entity.dart';
import '../../utils/colors.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({Key? key, required this.user}) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 12,
        minWidth: 12,
        maxWidth: 50,
        maxHeight: 50,
      ),
      decoration: BoxDecoration(
        border:
            Border.all(width: 2, color: getDivisionColor(user.division?.level)),
        shape: BoxShape.circle,
        image: user.avatarUrl != null
            ? DecorationImage(image: NetworkImage(user.avatarUrl!))
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
