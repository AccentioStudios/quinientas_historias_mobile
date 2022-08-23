import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/integrations/api_service/api_service.dart';

class UserProfileRepository with ApiService {
  Stream<User> getUserProfile(int? userId) async* {
    final endpoint =
        userId != null ? '/v1/users/profile/$userId' : '/v1/users/profile';

    yield* appApi
        .get(endpoint)
        .handleJson(mapper: (json) => User.fromJson(json));
  }
}
