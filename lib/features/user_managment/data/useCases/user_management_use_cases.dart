import '../models/user_management_request_model.dart';
import '../repositories/user_management_repositories.dart';

class UserManagementUseCases {
  UserManagementUseCases({required this.repository});
  final UserManagementRepository repository;

  Stream<void> registerUser(UserManagementRequest request) async* {
    yield* repository.registerUser(request);
  }

  Stream<void> editUser(UserManagementRequest request) async* {
    yield* repository.editUser(request);
  }
}
