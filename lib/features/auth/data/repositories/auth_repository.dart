import '../../../../core/integrations/api_service/api_service.dart';
import '../models/auth_model.dart';
import '../models/login_model.dart';

class AuthRepository with ApiService {
  Stream<AuthModel> login(LoginModel login) async* {
    yield* appApi.post('v1/auth/login', data: login.toJson()).handleJson(
        mapper: (data) {
      AuthModel authModel = AuthModel.fromMap(data);
      appApi.setAuth(authModel);
      return authModel;
    });
  }
}
