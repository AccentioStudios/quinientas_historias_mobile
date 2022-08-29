import '../models/invites_request_model.dart';
import '../models/invites_response_model.dart';
import '../repositories/invites_repository.dart';

class InvitesUseCases {
  InvitesUseCases({required this.repository});
  final InvitesRepository repository;

  Stream<InvitesResponse> sendInvite(InvitesRequest request) async* {
    yield* repository.sendInvite(request);
  }
}
