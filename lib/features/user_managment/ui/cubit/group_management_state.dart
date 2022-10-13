part of 'group_management_cubit.dart';

@freezed
class GroupManagementState with _$GroupManagementState {
  const factory GroupManagementState({
    @Default(false) isLoading,
    GroupManagementRequest? groupManagementRequest,
    CroppedFile? avatarMemory,
    HttpFailure? error,
  }) = _GroupManagementState;
}
