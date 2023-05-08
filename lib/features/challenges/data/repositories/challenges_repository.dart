import 'package:flutter/material.dart';

import '../../../../core/data/entities/challenge_sar_entity.dart';
import '../../../../core/integrations/api_service.dart';
import '../dto/register_new_challenge_response.dto.dart';
import '../entities/challenge_sar_event.dart';

class ChallengesRepository with ApiService {
  Stream<RegisterNewChallengeResponseDto> registerNewChallenge(
      ChallengeSar challenge) async* {
    yield* sarApi.post('/v1/challenge', data: challenge.toJson()).handleJson(
        mapper: (json) {
      debugPrint('Aqui');
      return RegisterNewChallengeResponseDto.fromMap(json);
    });
  }

  Stream<void> sendEvent(ChallengeSarEvent event) async* {
    yield* sarApi
        .post('/v1/event', data: event.toJson())
        .handleJson(mapper: (json) => ChallengeSarEvent.fromJson(json));
  }
}
