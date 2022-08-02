import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/bloc/cubit/user_profile_cubit.dart';
import 'ui/pages/user_profile_page.dart';

class UserProfileProvider extends StatelessWidget {
  const UserProfileProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserProfileCubit(),
      child: const UserProfilePage(),
    );
  }
}
