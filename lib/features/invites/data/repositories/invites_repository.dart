import 'dart:convert';

import '../../../../../core/data/entities/invites_entity.dart';
import '../../../../../core/integrations/api_service.dart';
import '../models/invites_request_model.dart';
import '../models/verify_invite_code_request_model.dart';

class InvitesRepository with ApiService {
  Stream<void> sendInvite(InvitesRequest request) async* {
    yield* appApi
        .post('/v1/invites/send', data: json.encode(request.toJson()))
        .handle(mapper: (Object data) {});
  }

  Stream<List<Invite>> getInvitations() async* {
    yield* appApi.get('/v1/invites').handle(
        mapper: (Object data) =>
            json.decode(data as String).map<Invite>((dynamic jsonMap) {
              return Invite.fromJson(jsonMap as Map<String, dynamic>);
            }).toList());
  }

  Stream<Invite> validateCode(VerifyInviteCodeRequest request) async* {
    yield* appApi
        .post('/v1/invites/verify', data: json.encode(request.toJson()))
        .handleJson(mapper: (data) {
      return Invite.fromJson(data);
    });
  }
}
