import '../../../../core/data/dto/auth_dto.dart';
import '../../../../core/helpers/secure_storage_helper.dart';
import '../../../../core/integrations/api_service.dart';
import '../models/accept_invite.dto.dart';

class UserManagementRepository with ApiService {
  Stream<void> acceptInvite(AcceptInviteDto dto) async* {
    final data = dto.toJson();
    yield* appApi.post('/v2/invite/accept', data: data).handle(
        mapper: (Object data) {
      if (data is Map<String, dynamic>) {
        if (data.containsKey('access_token')) {
          AuthDto authModel = AuthDto.decode(data);
          SecureStorageHelper.saveSession(authModel);
          return;
        }
      }
    });
  }

  Stream<void> editUser(UserDto request) async* {
    yield* appApi
        .post('/v1/users/edit', data: request.toJson())
        .handle(mapper: (Object data) {});
  }
}
