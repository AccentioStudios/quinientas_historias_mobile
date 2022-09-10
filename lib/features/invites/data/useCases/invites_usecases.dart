import '../../../../core/data/entities/invites_entity.dart';
import '../models/invites_request_model.dart';
import '../repositories/invites_repository.dart';

class InvitesUseCases {
  InvitesUseCases({required this.repository});
  final InvitesRepository repository;

  Stream<void> sendInvite(InvitesRequest request) async* {
    yield* repository.sendInvite(request);
  }

  Stream<List<Invite>> getInvitations() async* {
    yield* repository.getInvitations();
  }
}
