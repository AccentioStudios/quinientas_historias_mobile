import '../../../../core/integrations/api_service/api_service.dart';

class AuthRepository with ApiService {
  Stream<void> login() async* {
    yield* appApi.get('api/auth/login').handle(mapper: (data) => {});
  }
}
