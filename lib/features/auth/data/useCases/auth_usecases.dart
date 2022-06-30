import '../repositories/auth_repository.dart';

class AuthUseCases {
  AuthUseCases({required this.repository});
  final AuthRepository repository;

  Stream<void> login() async* {
    yield* repository.login();
  }
}
