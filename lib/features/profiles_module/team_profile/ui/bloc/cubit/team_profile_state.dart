part of 'team_profile_cubit.dart';

@freezed
class TeamProfileState with _$TeamProfileState {
  const factory TeamProfileState({
    @Default(true) isLoading,
    @Default(null) error,
    Team? team,
  }) = _TeamProfileState;
}
