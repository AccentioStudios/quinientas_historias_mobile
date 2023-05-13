import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../../core/data/entities/challenge_sar_entity.dart';
import '../../../../core/data/models/list_page.dart';
import '../dto/register_new_challenge_response.dto.dart';
import '../entities/challenge_sar_event.dart';
import '../repositories/challenges_repository.dart';

class ChallengesUseCases {
  ChallengesUseCases({required this.repository});
  final ChallengesRepository repository;

  Stream<ListPage<ChallengeSar>> getChallenges({
    int? id,
    String? title,
    int? tournamentId,
    String? orderBy,
    int? pageKey,
  }) async* {
    yield* repository.getChallenges(
      id: id,
      title: title,
      tournamentId: tournamentId,
      orderBy: orderBy,
      pageKey: pageKey,
    );
  }

  //acceptInvite
  Stream<RegisterNewChallengeResponseDto> registerNewChallenge(
      ChallengeSar challenge) async* {
    yield* repository.registerNewChallenge(challenge);
  }

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
