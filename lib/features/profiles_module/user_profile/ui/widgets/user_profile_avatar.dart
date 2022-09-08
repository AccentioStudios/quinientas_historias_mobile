import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/ui/widgets/user_avatar.dart';

class UserProfileAvatar extends StatelessWidget {
  const UserProfileAvatar(
      {Key? key,
      required this.user,
      this.canEdit = false,
      required this.editOnPressed})
      : super(key: key);

  final User? user;
  final bool canEdit;
  final void Function()? editOnPressed;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: <Widget>[
        UserAvatar(
          user: user!,
          width: 140,
          height: 140,
        ),
        if (canEdit)
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
