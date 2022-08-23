import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/user_profile_repository.dart';
import 'data/useCases/user_profile_usecases.dart';
import 'ui/bloc/cubit/user_profile_cubit.dart';
import 'ui/pages/user_profile_page.dart';

class UserProfileProvider extends StatelessWidget {
  const UserProfileProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as UserProfileArguments?;
    return BlocProvider(
      create: (context) => UserProfileCubit(
          userId: args?.id,
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
