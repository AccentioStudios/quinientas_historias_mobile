import 'dart:async' show Stream;

import 'package:quinientas_historias/core/data/entities/team_entity.dart';

import '../../../../../core/data/entities/invites_entity.dart';
import '../../../../core/data/entities/school_entity.dart';
import '../../../../core/data/entities/tournament_entity.dart';
import '../../../../core/data/entities/user_entity.dart';
import '../models/invites_request_model.dart';
import '../models/verify_invite_code_request_model.dart';
import '../repositories/invites_repository.dart';

class InvitesUseCases {
  InvitesUseCases({required this.repository});
  final InvitesRepository repository;

  Stream<List<User>> searchUsers(String email) async* {
    yield* repository.searchUsersFromWP(email);
  }

  Stream<void> sendInvite(CreateInviteDto request) async* {
    yield* repository.sendInvite(request);
  }

  Stream<List<Invite>> getInvitations({int? teamId}) async* {
    yield* repository.getInvitations(teamId: teamId);
  }

  Stream<void> deleteInvitation(Invite invite) async* {
    yield* repository.deleteInvitation(invite);
  }

  Stream<Invite> validateCode(VerifyInviteCodeRequest request) async* {
    yield* repository.validateCode(request);
  }

  Stream<List<Team>> getTeamsFromProf(int schoolId) async* {
    yield* repository.getTeamsFromProf(schoolId);
  }

  Stream<List<School>> getSchoolsForAdmin() async* {
    yield* repository.getSchoolsForAdmin();
  }

  Stream<List<Tournament>> getTournamentsForAdmin() async* {
    yield* repository.getTournamentsForAdmin();
  }
}
