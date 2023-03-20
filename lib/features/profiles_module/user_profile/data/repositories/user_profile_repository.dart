import '../../../../../core/data/dto/user_profile_dto.dart';
import '../../../../../core/integrations/api_service.dart';

class UserProfileRepository with ApiService {
  Stream<UserProfileDto> getUserProfile(int? userId) async* {
    yield* appApi
        .get('/v2/user/${userId.toString()}')
        .handleJson(mapper: (json) => UserProfileDto.fromJson(json));
  }
}
