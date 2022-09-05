import '../../../../../core/data/entities/daily_challenge_entity.dart';
import '../../../../../core/integrations/api_service/api_service.dart';

class DailyChallengeRepository with ApiService {
  Stream<DailyChallenge> getData() async* {
    yield* appApi
        .get('v1/challenges/dailyChallenge')
        .handleJson(mapper: (data) => DailyChallenge.fromJson(data));
  }

  Stream<DailyChallenge> generateNewDailyChallenge(bool forceGenerate) async* {
    yield* appApi.get('v1/challenges/generateNewDailyChallenge',
        queryParameters: {
          'force': forceGenerate.toString()
        }).handleJson(mapper: (data) => DailyChallenge.fromJson(data));
  }
}
