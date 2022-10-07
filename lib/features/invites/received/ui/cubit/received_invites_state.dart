part of 'received_invites_cubit.dart';

@freezed
class ReceivedInvitesState with _$ReceivedInvitesState {
  const factory ReceivedInvitesState({
    @Default(true) isLoading,
    Invite? invite,
    @Default('') String code,
  }) = _ReceivedInvitesState;
}
