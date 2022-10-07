import '../../../../core/integrations/api_service.dart';
import '../models/register_request_model.dart';

class UserManagementRepository with ApiService {
  Stream<void> registerUser(RegisterUserRequest request) async* {
    yield* appApi
        .post('/v1/users/register', data: request.toJson())
        .handle(mapper: (Object data) {});
  }
}
