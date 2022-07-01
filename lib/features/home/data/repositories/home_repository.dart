import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/integrations/api_service/api_service.dart';

class HomeRepository with ApiService {
  Stream<User> userData() async* {
    yield* appApi
        .get('/v1/users/data')
        .handleJson(mapper: (json) => User.fromJson(json));
  }

  Stream<User> dailyChallange() async* {
    yield* appApi
        .get('/v1/challanges/dailyChallange')
        .handleJson(mapper: (json) => User.fromJson(json));
  }
}
