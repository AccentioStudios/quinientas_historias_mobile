import 'package:get_it/get_it.dart';

import '../../../../core/data/dto/auth_dto.dart';
import '../../../../core/integrations/secure_storage_service.dart';
import '../../../../core/integrations/api_service.dart';
import '../models/accept_invite.dto.dart';

class UserManagementRepository with ApiService {
  Stream<void> sendNotification(int userId, dynamic body) {
    return appApi.post('/v2/user/send-notification/$userId', data: body).handle(
        mapper: (Object data) async {
      return;
    });
  }

  Stream<void> acceptInvite(AcceptInviteDto dto) async* {
    final data = dto.toJson();
    yield* appApi.post('/v2/invite/accept', data: data).handle(
        mapper: (Object data) async {
      if (data is Map<String, dynamic>) {
        if (data.containsKey('access_token')) {
          AuthDto authModel = AuthDto.decode(data);
          await GetIt.I<SecureStorageService>().saveSession(authModel);
          await appApi.refreshToken();
          return;
        }
      }
    });
  }

  Stream<void> editUser(UserDto request) async* {
    yield* appApi
        .patch('/v2/user/${request.id}', data: request.toJson())
        .handle(mapper: (Object data) async {
      await appApi.refreshToken();
      return;
    });
  }
}
