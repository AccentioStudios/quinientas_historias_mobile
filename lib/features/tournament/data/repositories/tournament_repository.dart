import '../../../../core/data/entities/leaderboard_entity.dart';
import '../../../../core/integrations/api_service.dart';
import '../../../../core/data/entities/tournament_entity.dart';

class TournamentRepository with ApiService {
  Stream<Tournament> getTournament(int id) async* {
    yield* appApi
        .get('v2/tournament/$id')
        .handleJson(mapper: (data) => Tournament.fromJson(data));
  }

  Stream<List<Tournament>> getAllTournaments() async* {
    yield* appApi.get('v2/tournament/').handle(mapper: (data) {
      return (data as List<dynamic>).map<Tournament>((dynamic item) {
        return Tournament.fromJson(item as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<Leaderboard>> getLeaderboard(
      int tournamentId, int pageKey, String filter) async* {
    yield* appApi
        .get('v2/tournament/$tournamentId/leaderboard', queryParameters: {
      'filter': filter,
    }).handle(mapper: (data) {
      return (data as List<dynamic>).map<Leaderboard>((dynamic item) {
        return Leaderboard.fromJson(item as Map<String, dynamic>);
      }).toList();
    });
    // .handle(
    //         mapper: (Object data) =>
    //             json.decode(data as String).map<Leaderboard>((dynamic jsonMap) {
    //               return Leaderboard.fromJson(jsonMap as Map<String, dynamic>);
    //             }).toList());
  }
}
