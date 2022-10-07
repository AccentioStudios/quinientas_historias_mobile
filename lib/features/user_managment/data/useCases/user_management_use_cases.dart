import '../models/register_request_model.dart';
import '../repositories/user_management_repositories.dart';

class UserManagementUseCases {
  UserManagementUseCases({required this.repository});
  final UserManagementRepository repository;

  Stream<void> registerUser(RegisterUserRequest request) async* {
    yield* repository.registerUser(request);
  }
}
