import 'dart:convert';

import '../../../../core/integrations/api_service.dart';
import '../../../../core/data/entities/tournament_entity.dart';
import '../../../../core/data/models/leaderboard_model.dart';

class TournamentRepository with ApiService {
  Stream<Tournament> getCurrentTournament() async* {
    yield* appApi
        .get('v1/tournament/data')
        .handleJson(mapper: (data) => Tournament.fromJson(data));
  }

  Stream<List<LeaderboardModel>> getLeaderboard(
      int pageKey, String filter) async* {
    yield* appApi.get('v1/leaderboard', queryParameters: {
      'filter': filter,
    }).handle(
        mapper: (Object data) => json
                .decode(data as String)
                .map<LeaderboardModel>((dynamic jsonMap) {
              return LeaderboardModel.fromJson(jsonMap as Map<String, dynamic>);
            }).toList());
  }
}
