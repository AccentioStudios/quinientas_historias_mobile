part of 'user_management_cubit.dart';

@freezed
class UserManagementState with _$UserManagementState {
  const factory UserManagementState({
    @Default(false) isLoading,
    @Default(false) uploadingAvatar,
    RegisterUserRequest? registerUser,
    HttpFailure? error,
  }) = _UserManagementState;
}
