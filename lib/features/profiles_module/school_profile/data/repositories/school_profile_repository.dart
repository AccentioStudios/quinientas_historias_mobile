import '../../../../../core/data/dto/school_profile_dto.dart';
import '../../../../../core/integrations/api_service.dart';

class SchoolProfileRepository with ApiService {
  Stream<SchoolProfileDto> getSchoolProfile(int? schoolId) async* {
    yield* appApi
        .get('/v2/school/$schoolId')
        .handleJson(mapper: (json) => SchoolProfileDto.fromJson(json));
  }
}
