import 'dart:convert';

import 'package:quinientas_historias/core/data/entities/team_entity.dart';

import '../../../../../core/data/entities/invites_entity.dart';
import '../../../../../core/integrations/api_service.dart';
import '../../../../core/data/entities/user_entity.dart';
import '../models/invites_request_model.dart';
import '../models/verify_invite_code_request_model.dart';

class InvitesRepository with ApiService {
  Stream<List<Team>> getTeamsFromProf(int schoolId) async* {
    yield* appApi.get('/v2/team', queryParameters: {
      'schoolId': schoolId.toString()
    }).handle(mapper: (Object data) {
      return (data as List<dynamic>).map<Team>((dynamic item) {
        return Team.fromJson(item as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<List<User>> searchUsers(String email) async* {
    yield* appApi.get('/v2/user', queryParameters: {'email': email}).handle(
        mapper: (Object data) {
      var test = (data as List<dynamic>).map<User>((dynamic item) {
        return User.fromJson(item as Map<String, dynamic>);
      }).toList();
      return test;
    });
  }

  Stream<List<User>> searchUsersFromWP(String email) async* {
    yield* appApi.get('/v2/user', queryParameters: {
      'wp': 'true',
      'email': email
    }).handle(mapper: (Object data) {
      var test = (data as List<dynamic>).map<User>((dynamic item) {
        return User.fromJson(item as Map<String, dynamic>);
      }).toList();
      return test;
    });
  }

  Stream<void> sendInvite(InvitesRequest request) async* {
    yield* appApi
        .post('/v2/invite', data: json.encode(request.toJson()))
        .handle(mapper: (Object data) {});
  }

  Stream<List<Invite>> getInvitations({int? teamId}) async* {
    yield* appApi
        .get('/v2/invite',
            queryParameters:
                teamId != null ? {'teamId': teamId.toString()} : null)
        .handle(mapper: (Object data) {
      return (data as List<dynamic>).map<Invite>((dynamic item) {
        return Invite.fromJson(item as Map<String, dynamic>);
      }).toList();
    });
  }

  Stream<void> deleteInvitation(Invite invite) async* {
    yield* appApi
        .delete('/v2/invite/${invite.id}')
        .handle(mapper: (Object data) {});
  }

  Stream<Invite> validateCode(VerifyInviteCodeRequest request) async* {
    yield* appApi
        .post('/v2/invite/verify', data: json.encode(request.toJson()))
        .handleJson(mapper: (data) {
      return Invite.fromJson(data);
    });
  }
}
