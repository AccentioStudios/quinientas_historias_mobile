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

  Future<void> _sendEvent(ChallengeSarEvent event, {bool force = false}) async {
    if (await isSARAvailable) {
      if (kDebugMode) {
        print('Added SAR event to queue. ${event.trigger}');
      }
      if (force) {
        return _challengeUseCases.sendEvent(event);
      } else {
        return queue.add<void>(() => _challengeUseCases.sendEvent(event));
      }
    }
  }

  emit(
    ChallengeSarTriggers trigger, {
    required int userId,
    int? storyId,
    bool force = false,
  }) {
    final DateTime now = DateTime.now();
    final event = ChallengeSarEvent(
      now: now,
      trigger: trigger,
      userId: userId,
      storyId: storyId,
    );

    return _sendEvent(event, force: force);
  }
}
