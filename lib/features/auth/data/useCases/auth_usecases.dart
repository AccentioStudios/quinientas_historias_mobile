import 'package:quinientas_historias/features/auth/data/models/auth_model.dart';
import 'package:quinientas_historias/features/auth/data/models/login_model.dart';

import '../repositories/auth_repository.dart';

class AuthUseCases {
  AuthUseCases({required this.repository});
  final AuthRepository repository;

  Stream<AuthModel> login(LoginModel login) async* {
    yield* repository.login(login);
  }
}
