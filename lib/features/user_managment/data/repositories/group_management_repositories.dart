import 'package:quinientas_historias/core/data/entities/school_entity.dart';

import '../../../../core/data/entities/team_entity.dart';
import '../../../../core/integrations/api_service.dart';

import '../models/group_management_request_model.dart';

class GroupManagementRepository with ApiService {
  Stream<Team> registerTeam(GroupManagementRequest request,
      {bool? join = false}) async* {
    yield* appApi.post('/v2/team', data: request.toJson(), queryParameters: {
      'join': join.toString(),
    }).handleJson(mapper: (data) {
      appApi.refreshToken();
      return Team.fromJson(data);
    });
  }

  Stream<void> editTeam(GroupManagementRequest request) async* {
    yield* appApi
        .patch('/v2/team/${request.id}', data: request.toJson())
        .handle(mapper: (Object data) async {
      await appApi.refreshToken();
      return;
    });
  }

  Stream<School> registerSchool(GroupManagementRequest request,
      {bool? join = false}) async* {
    yield* appApi.post('/v2/school', data: request.toJson(), queryParameters: {
      'join': join.toString(),
    }).handleJson(mapper: (data) {
      appApi.refreshToken();
      return School.fromJson(data);
    });
  }

  Stream<void> editSchool(GroupManagementRequest request) async* {
    yield* appApi
        .patch('/v2/school/${request.id}', data: request.toJson())
        .handle(mapper: (Object data) async {
      await appApi.refreshToken();
      return;
    });
  }
}
