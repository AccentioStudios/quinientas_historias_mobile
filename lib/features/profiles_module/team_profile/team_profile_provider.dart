import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/bloc/cubit/team_profile_cubit.dart';
import 'ui/pages/school_profile_page.dart';

class TeamProfileProvider extends StatelessWidget {
  const TeamProfileProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TeamProfileArguments;
    return BlocProvider(
      create: (context) => TeamProfileCubit(teamId: args.id),
      child: const TeamProfilePage(),
    );
  }
}

class TeamProfileArguments {
  final int id;
  TeamProfileArguments(this.id);
}
