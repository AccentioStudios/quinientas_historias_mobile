import '../../../../../core/integrations/api_service/api_service.dart';
import '../models/invites_request_model.dart';

class InvitesRepository with ApiService {
  Stream<void> sendInvite(InvitesRequest request) async* {
    yield* appApi
        .post('/v1/invites/send', data: request.toJson())
        .handleJson(mapper: (json) {});
  }
}
