import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cubit/daily_challenge_cubit.dart';
import 'data/repositories/daily_challenge_repository.dart';
import 'data/useCases/daily_challenge_usecases.dart';
import 'ui/pages/reading_challange_page.dart';

class DailyChallangeProvider extends StatelessWidget {
  const DailyChallangeProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DailyChallengeCubit(
          dailyChallengeUseCases:
              DailyChallengeUseCases(repository: DailyChallengeRepository())),
      child: const DailyChallengePage(),
    );
  }
}
