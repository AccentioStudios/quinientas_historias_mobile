import 'package:quinientas_historias/core/data/entities/daily_challenge_entity.dart';

import '../repositories/daily_challenge_repository.dart';

class DailyChallengeUseCases {
  DailyChallengeUseCases({required this.repository});
  final DailyChallengeRepository repository;

  Stream<DailyChallenge> getData() async* {
    yield* repository.getData();
  }
}
