import '../../../../core/data/entities/team_entity.dart';
import '../../../../core/integrations/api_service.dart';
import '../models/group_management_request_model.dart';

class GroupManagementRepository with ApiService {
  Stream<Team> registerTeam(GroupManagementRequest request) async* {
    yield* appApi
        .post('/v1/teams/register', data: request.toJson())
        .handleJson(mapper: (data) => Team.fromJson(data));
  }

  Stream<void> editTeam(GroupManagementRequest request) async* {
    yield* appApi
        .post('/v1/teams/edit', data: request.toJson())
        .handle(mapper: (Object data) {});
  }

  Stream<void> editSchool(GroupManagementRequest request) async* {
    yield* appApi
        .post('/v1/schools/edit', data: request.toJson())
        .handle(mapper: (Object data) {});
  }
}
