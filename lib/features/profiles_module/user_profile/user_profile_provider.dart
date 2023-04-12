import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/user_profile_repository.dart';
import 'data/useCases/user_profile_usecases.dart';
import 'ui/bloc/cubit/user_profile_cubit.dart';
import 'ui/pages/user_profile_page.dart';

@RoutePage()
class UserProfileProvider extends StatelessWidget {
  const UserProfileProvider({Key? key, @PathParam('id') this.userId})
      : super(key: key);
  final int? userId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit(
          userId: userId,
          userProfileUseCases:
              UserProfileUseCases(repository: UserProfileRepository())),
      child: const UserProfilePage(),
    );
  }
}

class UserProfileArguments {
  final int? id;
  UserProfileArguments(this.id);
}
