import '../models/accept_invite.dto.dart';
import '../repositories/user_management_repositories.dart';

class UserManagementUseCases {
  UserManagementUseCases({required this.repository});
  final UserManagementRepository repository;

  //acceptInvite
  Stream<void> acceptInvite(AcceptInviteDto dto) async* {
    yield* repository.acceptInvite(dto);
  }

  Stream<void> editUser(UserDto request) async* {
    yield* repository.editUser(request);
  }
}
