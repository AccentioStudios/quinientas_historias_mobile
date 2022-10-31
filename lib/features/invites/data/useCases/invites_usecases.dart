import 'package:quinientas_historias/core/data/entities/team_entity.dart';

import '../../../../../core/data/entities/invites_entity.dart';
import '../models/invites_request_model.dart';
import '../models/verify_invite_code_request_model.dart';
import '../repositories/invites_repository.dart';

class InvitesUseCases {
  InvitesUseCases({required this.repository});
  final InvitesRepository repository;

  Stream<void> sendInvite(InvitesRequest request) async* {
    yield* repository.sendInvite(request);
  }

  Stream<List<Invite>> getInvitations({int? teamId}) async* {
    yield* repository.getInvitations(teamId: teamId);
  }

  Stream<List<Invite>> deleteInvitation(Invite invite) async* {
    yield* repository.deleteInvitation(invite);
  }

  Stream<Invite> validateCode(VerifyInviteCodeRequest request) async* {
    yield* repository.validateCode(request);
  }

  Stream<List<Team>> getTeamsFromProf() async* {
    yield* repository.getTeamsFromProf();
  }
}
