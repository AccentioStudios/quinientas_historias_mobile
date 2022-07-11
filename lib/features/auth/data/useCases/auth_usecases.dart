import 'package:quinientas_historias/core/data/models/jwt_token_model.dart';
import 'package:quinientas_historias/features/auth/data/models/login_model.dart';

import '../repositories/auth_repository.dart';

class AuthUseCases {
  AuthUseCases({required this.repository});
  final AuthRepository repository;

  Stream<JWTTokenModel> login(LoginModel login) async* {
    yield* repository.login(login);
  }
}
