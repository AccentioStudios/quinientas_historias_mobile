import '../../../../core/data/entities/tournament_entity.dart';
import '../../../../core/data/models/leaderboard_model.dart';
import '../../../../core/data/models/list_page.dart';
import '../repositories/tournament_repository.dart';

class TournamentUseCases {
  TournamentUseCases({required this.repository});
  final TournamentRepository repository;

  Stream<Tournament> getCurrentTournament() async* {
    yield* repository.getCurrentTournament();
  }

  Stream<ListPage<LeaderboardModel>> getLeaderboard(
      int pageKey, String filter) async* {
    yield* repository.getLeaderboard(pageKey, filter).map((model) {
      return ListPage<LeaderboardModel>(
        grandTotalCount: model.length,
        itemList: model,
      );
    });
  }
}
