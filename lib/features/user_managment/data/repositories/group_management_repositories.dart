import '../../../../core/integrations/api_service.dart';
import '../models/group_management_request_model.dart';

class GroupManagementRepository with ApiService {
  Stream<void> registerTeam(GroupManagementRequest request) async* {
    yield* appApi
        .post('/v1/teams/register', data: request.toJson())
        .handle(mapper: (Object data) {});
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
