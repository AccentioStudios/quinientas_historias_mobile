import '../../../../../core/data/dto/team_profile_dto.dart';
import '../../../../../core/integrations/api_service.dart';

class TeamProfileRepository with ApiService {
  Stream<TeamProfileDto> getTeamProfile(int? teamId) async* {
    yield* appApi.get('/v2/team/$teamId').handleJson(mapper: (json) {
      return TeamProfileDto.fromJson(json);
    });
  }
}
