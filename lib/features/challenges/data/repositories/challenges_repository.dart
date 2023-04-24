import '../../../../core/integrations/api_service.dart';
import '../entities/challenge_sar_event.dart';

class ChallengesRepository with ApiService {
  Stream<void> sendEvent(ChallengeSarEvent event) async* {
    yield* sarApi
        .post('/v1/event', data: event.toJson())
        .handleJson(mapper: (json) => ChallengeSarEvent.fromJson(json));
  }
}
