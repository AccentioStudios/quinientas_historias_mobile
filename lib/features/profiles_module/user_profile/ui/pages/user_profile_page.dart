import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/core/ui/widgets/user_avatar.dart';
import 'package:quinientas_historias/core/utils/constants.dart';
import 'package:quinientas_historias/features/profiles_module/user_profile/ui/bloc/cubit/team_profile_cubit.dart';
import 'package:quinientas_historias/features/profiles_module/user_profile/ui/widgets/profilepic-widget.dart';

import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/ui/widgets/buttom_bar.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: ListView(
              children: <Widget>[
                /*UserAvatar(
                  user: user!,
                ),*/
                const SizedBox(
                  width: Constants.space18,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
