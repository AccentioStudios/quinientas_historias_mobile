import '../models/team_profile_model.dart';
import '../repositories/team_profile_repository.dart';

class TeamProfileUseCases {
  TeamProfileUseCases({required this.repository});
  final TeamProfileRepository repository;

  Stream<TeamProfile> getTeamProfile(int teamId) async* {
    yield* repository.getTeamProfile(teamId);
  }
}
