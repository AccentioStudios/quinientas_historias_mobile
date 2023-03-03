import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/integrations/api_service.dart';

class UserProfileRepository with ApiService {
  Stream<User> getUserProfile(int? userId) async* {
    yield* appApi
        .get('/v2/user/${userId.toString()}')
        .handleJson(mapper: (json) => User.fromJson(json));
  }
}
