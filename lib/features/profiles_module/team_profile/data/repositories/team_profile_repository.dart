import '../../../../../core/integrations/api_service/api_service.dart';
import '../models/team_profile_model.dart';

class TeamProfileRepository with ApiService {
  Stream<TeamProfile> getTeamProfile(int teamId) async* {
    yield* appApi
        .get('/v1/teams/profile/$teamId')
        .handleJson(mapper: (json) => TeamProfile.fromJson(json));
  }
}
