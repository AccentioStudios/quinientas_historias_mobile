import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/features/profiles_module/team_profile/data/repositories/team_profile_repository.dart';
import 'package:quinientas_historias/features/profiles_module/team_profile/data/useCases/team_profile_usecases.dart';

import 'ui/bloc/cubit/team_profile_cubit.dart';
import 'ui/pages/team_profile_page.dart';

class TeamProfileProvider extends StatelessWidget {
  const TeamProfileProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as TeamProfileArguments;
    return BlocProvider(
      create: (context) => TeamProfileCubit(
          teamId: args.id,
          teamProfileUseCases:
              TeamProfileUseCases(repository: TeamProfileRepository())),
      child: const TeamProfilePage(),
    );
  }
}

class TeamProfileArguments {
  final int id;
  TeamProfileArguments(this.id);
}
