import '../../../../../core/integrations/api_service/api_service.dart';
import '../models/school_profile_model.dart';

class SchoolProfileRepository with ApiService {
  Stream<SchoolProfile> getSchoolProfile(int schoolId) async* {
    yield* appApi
        .get('/v1/school/profile/$schoolId')
        .handleJson(mapper: (json) => SchoolProfile.fromJson(json));
  }
}
