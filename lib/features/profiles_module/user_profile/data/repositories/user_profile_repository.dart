import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/integrations/api_service.dart';

class UserProfileRepository with ApiService {
  Stream<User> getUserProfile(int? userId) async* {
    yield* appApi
        .get('/v1/users/profile',
            queryParameters:
                userId != null ? {'userId': userId.toString()} : null)
        .handleJson(mapper: (json) => User.fromJson(json));
  }
}
