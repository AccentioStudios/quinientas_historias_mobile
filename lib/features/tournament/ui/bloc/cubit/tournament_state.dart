part of 'tournament_cubit.dart';

@freezed
class TournamentState with _$TournamentState {
  const factory TournamentState({
    @Default(true) tournamentIsLoading,
    @Default(true) leaderboardIsLoading,
    Tournament? tournament,
    ListPage<LeaderboardModel>? listPage,
    @Default(true) bool teamTabShowed,
  }) = _TournamentState;
}
