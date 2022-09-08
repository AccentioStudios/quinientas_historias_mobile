import 'package:flutter/material.dart';

import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/user_profile_cubit.dart';
import 'user_profile_avatar.dart';

class UserProfileHeader extends StatelessWidget {
  const UserProfileHeader({Key? key, required this.state}) : super(key: key);

  final UserProfileState state;

  @override
  Widget build(BuildContext context) {
    const TextStyle userNameProfileTextStyle =
        (TextStyle(fontSize: 24, fontWeight: FontWeight.bold));

    return PaddingColumn(
      padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
      children: <Widget>[
        UserProfileAvatar(
          user: state.user,
          canEdit: state.isMyProfile,
          editOnPressed: () {},
        ),
        const SizedBox(height: Constants.space18),
        Text(state.user!.firstName ?? '', style: userNameProfileTextStyle),
      ],
    );
  }
}
