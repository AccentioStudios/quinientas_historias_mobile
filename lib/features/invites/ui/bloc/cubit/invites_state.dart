part of 'invites_cubit.dart';

@freezed
class InvitesState with _$InvitesState {
  const factory InvitesState({
    @Default(true) isLoading,
    @Default(false) sendingInvite,
    @Default(initInvites) List<Invite> invites,
    @Default(false) formValidationError,
    User? user,
  }) = _InvitesState;
}

const List<Invite> initInvites = [];
