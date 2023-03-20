part of 'user_profile_cubit.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    @Default(true) bool isLoading,
    @Default(false) bool isMyProfile,
    @Default(null) HttpFailure? httpFailure,
    UserProfileDto? user,
  }) = _UserProfileState;
}
