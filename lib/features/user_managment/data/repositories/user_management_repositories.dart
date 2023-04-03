import '../../../../core/integrations/api_service.dart';
import '../models/accept_invite.dto.dart';

class UserManagementRepository with ApiService {
  Stream<void> registerUser(AcceptInviteDto dto) async* {
    yield* appApi
        .post('/v1/users/register', data: dto.toJson())
        .handle(mapper: (Object data) {});
  }

  Stream<void> acceptInvite(AcceptInviteDto dto) async* {
    yield* appApi
        .post('/v2/invite/accept', data: dto.toJson())
        .handle(mapper: (Object data) {});
  }

  Stream<void> editUser(UserDto request) async* {
    yield* appApi
        .post('/v1/users/edit', data: request.toJson())
        .handle(mapper: (Object data) {});
  }
}
