import '../../../../../core/data/entities/school_entity.dart';
import '../../../../../core/integrations/api_service.dart';

class SchoolProfileRepository with ApiService {
  Stream<School> getSchoolProfile(int? schoolId) async* {
    yield* appApi
        .get('/v1/school/profile',
            queryParameters:
                schoolId != null ? {'teamId': schoolId.toString()} : null)
        .handleJson(mapper: (json) => School.fromJson(json));
  }
}
