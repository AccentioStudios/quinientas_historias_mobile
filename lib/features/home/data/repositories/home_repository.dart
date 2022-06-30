import '../../../../core/integrations/api_service/api_service.dart';
import '../../../auth/data/entities/user_entity.dart';

class HomeRepository with ApiService {
  Stream<User> userData() async* {
    yield* appApi
        .get('users/v1/data')
        .handleJson(mapper: (data) => User.fromJson(data));
  }
}
