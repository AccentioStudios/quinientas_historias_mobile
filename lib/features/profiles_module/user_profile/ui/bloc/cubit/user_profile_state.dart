part of 'user_profile_cubit.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    @Default(true) isLoading,
    @Default(false) isMyProfile,
    @Default(null) error,
    User? user,
  }) = _UserProfileState;
}
