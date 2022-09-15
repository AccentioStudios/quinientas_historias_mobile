import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/integrations/api_service.dart';
import '../entities/dashboard_entity.dart';

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

  Stream<Dashboard> getDashboard() async* {
    yield* appApi
        .get('/v1/dashboard/data')
        .handleJson(mapper: (json) => Dashboard.fromJson(json));
  }

  Stream<List<Story>> getStories() async* {
    yield* appApi.get('/v1/dashboard/data').handleJson(mapper: (json) {
      List<Story> list = [];
      return list;
    });
  }
}
