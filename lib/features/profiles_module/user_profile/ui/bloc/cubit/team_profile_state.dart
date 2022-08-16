part of 'team_profile_cubit.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    @Default(false) isLoading,
    UserProfile? data,
  }) = _UserProfileState;
}
