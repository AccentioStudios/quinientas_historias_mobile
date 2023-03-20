import '../../../../../core/data/dto/team_profile_dto.dart';
import '../../../../../core/data/entities/team_entity.dart';
import '../repositories/team_profile_repository.dart';

class TeamProfileUseCases {
  TeamProfileUseCases({required this.repository});
  final TeamProfileRepository repository;

  Stream<TeamProfileDto> getTeamProfile(int teamId) async* {
    yield* repository.getTeamProfile(teamId);
  }
}
