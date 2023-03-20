part of 'tournament_cubit.dart';

@freezed
class TournamentState with _$TournamentState {
  const factory TournamentState({
    @Default(true) tournamentIsLoading,
    @Default(true) leaderboardIsLoading,
    @Default([]) List<Tournament> tournaments,
    ListPage<Leaderboard>? listPage,
    @Default(true) bool teamTabShowed,
  }) = _TournamentState;
}
