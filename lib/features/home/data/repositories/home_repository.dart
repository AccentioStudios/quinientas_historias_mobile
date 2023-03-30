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
    yield* appApi.get('/v2/dashboard').handleJson(mapper: (json) {
      Dashboard dashboard = Dashboard.fromJson(json);
      dashboard.mySummary = dashboard.mySummary.map((e) {
        // convert to MySummaryGroup using fromJson() if property groupType exists
        if (e.containsKey('groupType')) {
          e = MySummaryGroup.fromJson(e);
          return e;
        }
        if (e.containsKey('challengeType')) {
          e = MySummaryChallenge.fromJson(e);
          return e;
        }
      }).toList();
      return dashboard;
    });
  }
}
