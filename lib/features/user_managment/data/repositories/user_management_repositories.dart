import '../../../../core/integrations/api_service.dart';
import '../models/user_management_request_model.dart';

class UserManagementRepository with ApiService {
  Stream<void> registerUser(UserManagementRequest request) async* {
    yield* appApi
        .post('/v1/users/register', data: request.toJson())
        .handle(mapper: (Object data) {});
  }

  Stream<void> editUser(UserManagementRequest request) async* {
    yield* appApi
        .post('/v1/users/edit', data: request.toJson())
        .handle(mapper: (Object data) {});
  }
}
