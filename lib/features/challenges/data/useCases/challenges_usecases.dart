import 'dart:async';

import 'package:flutter/foundation.dart';

import '../entities/challenge_sar_event.dart';
import '../repositories/challenges_repository.dart';

class ChallengesUseCases {
  ChallengesUseCases({required this.repository});
  final ChallengesRepository repository;

  Future<void> sendEvent(ChallengeSarEvent event) async {
    Completer<void> _completer = Completer();
    if (kDebugMode) {
      print('Sending SAR event to server. ${event.trigger}');
    }
    repository.sendEvent(event).listen((_) {
      _completer.complete();
    }, onError: (error) {
      _completer.completeError(error);
    });

    return _completer.future;
  }
}
