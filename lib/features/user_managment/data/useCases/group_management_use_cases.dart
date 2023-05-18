import 'package:quinientas_historias/core/data/entities/school_entity.dart';

import '../../../../core/data/entities/team_entity.dart';

import '../models/group_management_request_model.dart';
import '../repositories/group_management_repositories.dart';

class GroupManagementUseCases {
  GroupManagementUseCases({required this.repository});
  final GroupManagementRepository repository;

  Stream<Team> registerTeam(
    GroupManagementRequest request, {
    bool? join = false,
  }) async* {
    yield* repository.registerTeam(request, join: join);
  }

  Stream<void> editTeam(GroupManagementRequest request) async* {
    yield* repository.editTeam(request);
  }

  Stream<School> registerSchool(
    GroupManagementRequest request, {
    bool? join = false,
  }) async* {
    yield* repository.registerSchool(request, join: join);
  }

  Stream<void> editSchool(GroupManagementRequest request) async* {
    yield* repository.editSchool(request);
  }
}
