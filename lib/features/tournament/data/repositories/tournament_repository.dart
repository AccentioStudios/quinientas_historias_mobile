import '../../../../../core/integrations/api_service/api_service.dart';
import '../../../../core/data/entities/tournament_entity.dart';
import '../../../../core/data/models/leaderboard_model.dart';

class TournamentRepository with ApiService {
  Stream<Tournament> getCurrentTournament() async* {
    yield* appApi
        .get('v1/tournament/data')
        .handleJson(mapper: (data) => Tournament.fromJson(data));
  }

  Stream<LeaderboardFilterModel> getLeaderboard(
      int pageKey, String filter) async* {
    yield* appApi.get('v1/leaderboard', queryParameters: {
      'filter': filter,
    }).handleJson(mapper: (json) => LeaderboardFilterModel.fromJson(json));
  }
}
