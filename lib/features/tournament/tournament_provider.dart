import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/bloc/cubit/tournament_cubit.dart';
import 'ui/pages/tournament_page.dart';

class TournamentProvider extends StatelessWidget {
  const TournamentProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TournamentCubit(),
      child: const TournamentPage(),
    );
  }
}
