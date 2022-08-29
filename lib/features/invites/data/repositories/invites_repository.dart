import '../../../../../core/integrations/api_service/api_service.dart';
import '../models/invites_request_model.dart';
import '../models/invites_response_model.dart';

class InvitesRepository with ApiService {
  Stream<InvitesResponse> sendInvite(InvitesRequest request) async* {
    yield* appApi
        .post('/v1/invites/send', data: request.toJson())
        .handleJson(mapper: (json) => InvitesResponse.fromJson(json));
  }
}
