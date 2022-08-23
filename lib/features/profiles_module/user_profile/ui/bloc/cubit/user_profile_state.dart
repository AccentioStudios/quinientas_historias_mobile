part of 'user_profile_cubit.dart';

@freezed
class UserProfileState with _$UserProfileState {
  const factory UserProfileState({
    @Default(false) isLoading,
    User? user,
  }) = _UserProfileState;
}
