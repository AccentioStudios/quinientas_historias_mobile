import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/challenges_repository.dart';
import 'data/useCases/challenges_usecases.dart';
import 'ui/cubit/challenges_admin_cubit.dart';

@RoutePage()
class ChallengesAdminProvider extends StatelessWidget {
  const ChallengesAdminProvider({
    Key? key,
    @QueryParam('testMode') this.testMode,
  }) : super(key: key);
  final String? testMode;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChallengesAdminCubit(
          challengesUseCases:
              ChallengesUseCases(repository: ChallengesRepository())),
      child: const AutoRouter(),
    );
  }
}
