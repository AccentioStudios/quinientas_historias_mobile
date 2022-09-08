part of 'team_profile_cubit.dart';

@freezed
class TeamProfileState with _$TeamProfileState {
  const factory TeamProfileState({
    @Default(true) isLoading,
    @Default(false) canEdit,
    @Default(false) isMyTeam,
    @Default(null) error,
    Team? team,
  }) = _TeamProfileState;
}
