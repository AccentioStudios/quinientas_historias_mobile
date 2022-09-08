import '../../../../../core/data/entities/team_entity.dart';
import '../../../../../core/integrations/api_service/api_service.dart';

class TeamProfileRepository with ApiService {
  Stream<Team> getTeamProfile(int? teamId) async* {
    yield* appApi
        .get('/v1/teams/profile',
            queryParameters:
                teamId != null ? {'teamId': teamId.toString()} : null)
        .handleJson(mapper: (json) => Team.fromJson(json));
  }
}
