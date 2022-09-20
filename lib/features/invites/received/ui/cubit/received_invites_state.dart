part of 'received_invites_cubit.dart';

@freezed
class ReceivedInvitesState with _$ReceivedInvitesState {
  const factory ReceivedInvitesState({
    User? whoIsInviting,
    Team? team,
    School? school,
    @Default('') String code,
    @Default(true) isLoading,
    @Default(false) formValidationError,
  }) = _ReceivedInvitesState;
}
