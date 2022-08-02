import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../school_profile/ui/bloc/cubit/school_profile_cubit.dart';
import 'ui/pages/team_profile_page.dart';

class TeamProfileProvider extends StatelessWidget {
  const TeamProfileProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SchoolProfileCubit(),
      child: const TeamProfilePage(),
    );
  }
}
