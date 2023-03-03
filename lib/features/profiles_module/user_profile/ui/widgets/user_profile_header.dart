import 'package:flutter/material.dart';

import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/user_avatar.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/user_profile_cubit.dart';

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
        UserAvatar(
          user: state.user!,
          width: 140,
          height: 140,
        ),
        const SizedBox(height: Constants.space18),
        Text('${state.user!.firstName} ${state.user!.lastName ?? ''}',
            style: userNameProfileTextStyle),
      ],
    );
  }
}
