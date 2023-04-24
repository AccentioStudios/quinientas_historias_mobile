import 'package:flutter/foundation.dart';
import 'package:queue/queue.dart';
import 'package:quinientas_historias/features/challenges/data/repositories/challenges_repository.dart';

import 'data/entities/challenge_sar_event.dart';
import 'data/useCases/challenges_usecases.dart';

class SARService {
  final queue = Queue(delay: const Duration(seconds: 1));

  final _challengeUseCases =
      ChallengesUseCases(repository: ChallengesRepository());

  Future<bool> get isSARAvailable async {
    return Future.value(true);
  }

  Future<void> _sendEvent(ChallengeSarEvent event) async {
    if (await isSARAvailable) {
      if (kDebugMode) {
        print('Added SAR event to queue. ${event.trigger}');
      }
      queue.add(() => _challengeUseCases.sendEvent(event));
    }
  }

  emit(
    ChallengeSarTriggers trigger, {
    required int userId,
    int? storyId,
  }) {
    final DateTime now = DateTime.now();
    final event = ChallengeSarEvent(
      now: now,
      trigger: trigger,
      userId: userId,
      storyId: storyId,
    );

    return _sendEvent(event);
  }
}
