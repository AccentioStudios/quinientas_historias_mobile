import 'package:quinientas_historias/core/data/entities/daily_challenge_entity.dart';

import '../repositories/daily_challenge_repository.dart';

class DailyChallengeUseCases {
  DailyChallengeUseCases({required this.repository});
  final DailyChallengeRepository repository;

  Stream<DailyChallenge> getData(
      {bool softGenerateNewChallenge = false,
      bool forceGenerateNewChallenge = false}) async* {
    if (softGenerateNewChallenge || forceGenerateNewChallenge) {
      yield* repository.generateNewDailyChallenge(forceGenerateNewChallenge);
    }
    yield* repository.getData();
  }

  Stream<DailyChallenge> generateNewDailyChallenge(
      {bool forceGenerateNewChallenge = false}) async* {
    yield* repository.generateNewDailyChallenge(forceGenerateNewChallenge);
  }
}
