part of 'user_management_cubit.dart';

@freezed
class UserManagementState with _$UserManagementState {
  const factory UserManagementState({
    @Default(false) isLoading,
    UserManagementRequest? userManagementRequest,
    CroppedFile? avatarMemory,
    HttpFailure? error,
  }) = _UserManagementState;
}
