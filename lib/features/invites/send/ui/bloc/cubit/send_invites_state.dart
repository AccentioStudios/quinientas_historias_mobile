part of 'send_invites_cubit.dart';

@freezed
class SendInvitesState with _$SendInvitesState {
  const factory SendInvitesState({
    @Default(true) isLoading,
    @Default(false) sendingInvite,
    @Default(initInvites) List<Invite> invites,
    @Default(initProfTeams) List<Team> profTeams,
    @Default(false) formValidationError,
    User? user,
  }) = _SendInvitesState;
}

const List<Invite> initInvites = [];
const List<Team> initProfTeams = [];
