part of 'send_invites_cubit.dart';

@freezed
class SendInvitesState with _$SendInvitesState {
  const factory SendInvitesState({
    @Default(true) isLoading,
    @Default(true) isSearchingUsers,
    @Default(false) sendingInvite,
    @Default(initInvites) List<Invite> invites,
    @Default(initProfTeams) List<Team> profTeams,
    @Default(initAdminSchools) List<School> adminSchools,
    @Default(false) emailIsValid,
    @Default(initSearchUsersList) searchUsersList,
    User? user,
  }) = _SendInvitesState;
}

const List<Invite> initInvites = [];
const List<Team> initProfTeams = [];
const List<School> initAdminSchools = [];
const List<User> initSearchUsersList = [];
