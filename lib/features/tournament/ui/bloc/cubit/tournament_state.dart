part of 'tournament_cubit.dart';

@freezed
class TournamentState with _$TournamentState {
  const factory TournamentState({
    @Default(false) tournamentIsLoading,
    Tournament? tournament,
  }) = _TournamentState;
}
