import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/data/entities/daily_challenge_entity.dart';
import '../../home/ui/bloc/cubit/home_cubit.dart';
import 'data/repositories/daily_challenge_repository.dart';
import 'data/useCases/daily_challenge_usecases.dart';
import 'ui/bloc/cubit/daily_challenge_cubit.dart';
import 'ui/pages/reading_challange_page.dart';

class DailyChallangeProvider extends StatelessWidget {
  const DailyChallangeProvider({
    Key? key,
    this.dailyChallenge,
    required this.homeCubit,
    this.softGenerateNewChallenge = false,
    this.forceGenerateNewChallenge = false,
  }) : super(key: key);

  // pass a daily challenge to screen, if this is not null, we dont automatically load from server. Instead we use this.
  final DailyChallenge? dailyChallenge;
  // When enter to first screen, automatically generate a new challenge keeping the last unreaded and reading stories.
  final bool softGenerateNewChallenge;
  // When enter to first screen, force to generate a totally new challenge.
  final bool forceGenerateNewChallenge;
  final HomeCubit homeCubit;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => DailyChallengeCubit(
              dailyChallengeUseCases: DailyChallengeUseCases(
                  repository: DailyChallengeRepository())),
        ),
        BlocProvider.value(
          value: homeCubit,
        ),
      ],
      child: DailyChallengePage(
        dailyChallenge: dailyChallenge,
        softGenerateNewChallenge: softGenerateNewChallenge,
        forceGenerateNewChallenge: forceGenerateNewChallenge,
      ),
    );
  }
}
