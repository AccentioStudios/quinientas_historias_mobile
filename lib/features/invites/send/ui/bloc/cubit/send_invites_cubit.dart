import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/school_entity.dart';
import 'package:quinientas_historias/core/data/entities/team_entity.dart';

import '../../../../../../core/data/entities/invites_entity.dart';
import '../../../../../../core/data/entities/tournament_entity.dart';
import '../../../../../../core/data/entities/user_entity.dart';
import '../../../../../../core/mixins/form_validation.dart';
import '../../../../../../core/mixins/stream_disposable.dart';
import '../../../../data/models/invites_request_model.dart';
import '../../../../data/useCases/invites_usecases.dart';

part 'send_invites_cubit.freezed.dart';
part 'send_invites_state.dart';

class SendInvitesCubit extends Cubit<SendInvitesState>
    with StreamDisposable, FormValidation {
  SendInvitesCubit({
    required this.invitesUseCases,
  }) : super(const SendInvitesState());

  final InvitesUseCases invitesUseCases;

  validateForm(String s) {
    // Validate explicit email format
    if (!validateEmail(s)) {
      emit(state.copyWith(emailIsValid: false));
    } else {
      emit(state.copyWith(emailIsValid: true));
    }
  }

  searchUsers(String email) {
    emit(state.copyWith(isSearchingUsers: true));

    // Allows to search for like emails
    if (validateUserSearchEmail(email) == true) {
      // Validate explicit email format
      validateForm(email);
      invitesUseCases.searchUsers(email).listen((searchUsersList) {
        emit(state.copyWith(
            searchUsersList: searchUsersList, isSearchingUsers: false));
      }, onError: (error) {
        emit(state.copyWith(isSearchingUsers: false));
      }).subscribe(this);
    } else {
      emit(state.copyWith(isSearchingUsers: false));
    }
  }

  sendInvite(CreateInviteDto request,
      {required Function onSuccess, required Function onError}) async {
    emit(state.copyWith(sendingInvite: true));
    invitesUseCases.sendInvite(request).listen((_) {
      onSuccess();
      emit(state.copyWith(sendingInvite: false));
    }, onError: (error) {
      onError(error);
    }).subscribe(this);
  }

  getInvitations(
      {int? teamId, required Function onSuccess, required Function onError}) {
    emit(state.copyWith(isLoading: true));

    invitesUseCases.getInvitations(teamId: teamId).listen((invites) {
      emit(state.copyWith(invites: invites, isLoading: false));
      onSuccess();
    }, onError: (error) {
      onError(error);
    }).subscribe(this);
  }

  deleteInvitation(Invite invite,
      {required Function onSuccess, required Function onError}) {
    emit(state.copyWith(isLoading: true));

    invitesUseCases.deleteInvitation(invite).listen((_) {
      onSuccess();
    }, onError: (error) {
      onError(error);
      emit(state.copyWith(isLoading: false));
    }).subscribe(this);
  }

  Future<void> getTeamsFromProf(int schoolId) async {
    var completer = Completer<void>();
    emit(state.copyWith(isLoading: true));
    invitesUseCases.getTeamsFromProf(schoolId).listen((teams) {
      emit(state.copyWith(profTeams: teams, isLoading: false));
      completer.complete();
    }, onError: (error) {
      completer.completeError(error);
    }).subscribe(this);
    return completer.future;
  }

  Future<void> getSchoolsForAdmin() async {
    var completer = Completer<void>();
    emit(state.copyWith(isLoading: true));
    invitesUseCases.getSchoolsForAdmin().listen((schools) {
      emit(state.copyWith(adminSchools: schools, isLoading: false));
      completer.complete();
    }, onError: (error) {
      completer.completeError(error);
    }).subscribe(this);
    return completer.future;
  }

  Future<void> getTournamentsForAdmin() async {
    var completer = Completer<void>();
    emit(state.copyWith(isLoading: true));
    invitesUseCases.getTournamentsForAdmin().listen((tournaments) {
      emit(state.copyWith(tournaments: tournaments, isLoading: false));
      completer.complete();
    }, onError: (error) {
      completer.completeError(error);
    }).subscribe(this);
    return completer.future;
  }
}
