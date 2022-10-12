part of 'tournament_cubit.dart';

@freezed
class TournamentState with _$TournamentState {
  const factory TournamentState({
    @Default(false) tournamentIsLoading,
    @Default(false) leaderboardIsLoading,
    Tournament? tournament,
    ListPage<LeaderboardModel>? listPage,
  }) = _TournamentState;
}
