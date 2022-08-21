import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/features/tournament/data/repositories/tournament_repository.dart';
import 'package:quinientas_historias/features/tournament/data/useCases/tournament_usecases.dart';

import 'ui/bloc/cubit/tournament_cubit.dart';
import 'ui/pages/tournament_page.dart';

class TournamentProvider extends StatelessWidget {
  const TournamentProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TournamentCubit(
          tournamentUseCases:
              TournamentUseCases(repository: TournamentRepository())),
      child: const TournamentPage(),
    );
  }
}
