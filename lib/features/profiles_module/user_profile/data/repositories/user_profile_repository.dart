import '../../../../../core/integrations/api_service/api_service.dart';
import '../models/user_profile_model.dart';

class UserProfileRepository with ApiService {
  Stream<UserProfile> getUserProfile(int userId) async* {
    yield* appApi
        .get('/v1/users/profile/$userId')
        .handleJson(mapper: (json) => UserProfile.fromJson(json));
  }
}
