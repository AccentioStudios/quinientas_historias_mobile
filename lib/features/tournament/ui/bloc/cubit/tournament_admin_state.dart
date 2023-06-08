part of 'tournament_admin_cubit.dart';

@freezed
class TournamentAdminState with _$TournamentAdminState {
  const factory TournamentAdminState({
    @Default(false) isLoading,
    @Default(false) creatingTournamentLoading,
    @Default([]) List<Tournament> tournaments,
    @Default([]) List<Tag> tags,
    TournamentDto? tournament,
    Object? error,
  }) = _TournamentAdminState;
}
