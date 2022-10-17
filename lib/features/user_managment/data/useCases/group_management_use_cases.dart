import '../../../../core/data/entities/team_entity.dart';
import '../models/group_management_request_model.dart';
import '../repositories/group_management_repositories.dart';

class GroupManagementUseCases {
  GroupManagementUseCases({required this.repository});
  final GroupManagementRepository repository;

  Stream<Team> registerTeam(GroupManagementRequest request) async* {
    yield* repository.registerTeam(request);
  }

  Stream<void> editTeam(GroupManagementRequest request) async* {
    yield* repository.editTeam(request);
  }

  Stream<void> editSchool(GroupManagementRequest request) async* {
    yield* repository.editSchool(request);
  }
}
