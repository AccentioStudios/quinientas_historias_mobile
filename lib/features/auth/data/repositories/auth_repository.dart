import '../../../../core/integrations/api_service/api_service.dart';
import '../../../../core/data/models/jwt_token_model.dart';
import '../models/login_model.dart';

class AuthRepository with ApiService {
  Stream<JWTTokenModel> login(LoginModel login) async* {
    yield* appApi.post('v1/auth/login', data: login.toJson()).handleJson(
        mapper: (data) {
      JWTTokenModel authModel = JWTTokenModel.decode(data);
      appApi.setAuth(authModel);
      return authModel;
    });
  }
}
