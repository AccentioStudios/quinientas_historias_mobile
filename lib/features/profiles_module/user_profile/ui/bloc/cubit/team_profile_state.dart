part of 'team_profile_cubit.dart';

@freezed
class TeamProfileState with _$TeamProfileState {
  const factory TeamProfileState({
    @Default(false) isLoading,
    SchoolProfile? data,
  }) = _SchoolProfileState;
}
