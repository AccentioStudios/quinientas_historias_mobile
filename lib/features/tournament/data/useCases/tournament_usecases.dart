import '../../../../core/data/entities/leaderboard_entity.dart';
import '../../../../core/data/entities/tournament_entity.dart';
import '../../../../core/data/models/list_page.dart';
import '../repositories/tournament_repository.dart';

class TournamentUseCases {
  TournamentUseCases({required this.repository});
  final TournamentRepository repository;

  Stream<Tournament> getTournament(int id) async* {
    yield* repository.getTournament(id);
  }

  Stream<List<Tournament>> getAllTournaments() async* {
    yield* repository.getAllTournaments();
  }

  Stream<ListPage<Leaderboard>> getLeaderboard(
      int tournamentId, int pageKey, String filter) async* {
    yield* repository
        .getLeaderboard(tournamentId, pageKey, filter)
        .map((model) {
      return ListPage<Leaderboard>(
        grandTotalCount: model.length,
        itemList: model,
      );
    });
  }
}
