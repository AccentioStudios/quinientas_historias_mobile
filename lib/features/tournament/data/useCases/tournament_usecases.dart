import '../../../../core/data/entities/leaderboard_entity.dart';
import '../../../../core/data/entities/tag_entity.dart';
import '../../../../core/data/entities/tournament_entity.dart';
import '../../../../core/data/models/list_page.dart';
import '../dto/tournament.dto.dart';
import '../repositories/tournament_repository.dart';

class TournamentUseCases {
  TournamentUseCases({required this.repository});
  final TournamentRepository repository;

  Stream<Tournament> getTournament(int id) async* {
    yield* repository.getTournament(id);
  }

  Stream<Tournament> registerNewTournament(TournamentDto dto) async* {
    yield* repository.registerNewTournament(dto);
  }

  Stream<void> editTournament(TournamentDto dto) async* {
    yield* repository.editTournament(dto);
  }

  Stream<List<Tournament>> getAllTournaments() async* {
    yield* repository.getAllTournaments();
  }

  Stream<List<Tag>> getTagsFromWordpress() async* {
    yield* repository.getTagsFromWordpress();
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
