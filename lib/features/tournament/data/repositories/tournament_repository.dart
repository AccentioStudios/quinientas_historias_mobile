import '../../../../core/data/entities/leaderboard_entity.dart';
import '../../../../core/data/entities/tag_entity.dart';
import '../../../../core/integrations/api_service.dart';
import '../../../../core/data/entities/tournament_entity.dart';
import '../dto/tournament.dto.dart';

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

  Stream<Tournament> registerNewTournament(TournamentDto dto) async* {
    yield* appApi
        .post('v2/tournament/', data: dto.toJson())
        .handleJson(mapper: (data) => Tournament.fromJson(data));
  }

  Stream<void> editTournament(TournamentDto dto) async* {
    yield* appApi.patch('v2/tournament/${dto.id}', data: dto.toJson()).handle(
        mapper: (Object data) async {
      return;
    });
  }

  Stream<List<Tag>> getTagsFromWordpress() async* {
    yield* appApi.get('v2/tournament/tags').handle(mapper: (data) {
      return (data as List<dynamic>).map<Tag>((dynamic item) {
        return Tag.fromJson(item as Map<String, dynamic>);
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
