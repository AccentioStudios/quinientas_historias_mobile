part of 'user_management_cubit.dart';

@freezed
class UserManagementState with _$UserManagementState {
  const factory UserManagementState({
    @Default(false) isLoading,
    UserDto? user,
    CroppedFile? avatarMemory,
    HttpFailure? error,
    Invite? invite,
  }) = _UserManagementState;
}
