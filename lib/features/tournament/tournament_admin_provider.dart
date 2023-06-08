import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/features/tournament/ui/bloc/cubit/tournament_admin_cubit.dart';

import 'data/repositories/tournament_repository.dart';
import 'data/useCases/tournament_usecases.dart';

@RoutePage()
class TournamentAdminProvider extends StatelessWidget {
  const TournamentAdminProvider({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TournamentAdminCubit(
          tournamentUseCases:
              TournamentUseCases(repository: TournamentRepository())),
      child: const AutoRouter(),
    );
  }
}
