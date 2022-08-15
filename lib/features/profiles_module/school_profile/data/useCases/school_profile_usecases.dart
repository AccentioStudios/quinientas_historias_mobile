import '../models/school_profile_model.dart';
import '../repositories/school_profile_repository.dart';

class SchoolProfileUseCases {
  SchoolProfileUseCases({required this.repository});
  final SchoolProfileRepository repository;

  Stream<SchoolProfile> getSchool(int schoolId) async* {
    yield* repository.getSchoolProfile(schoolId);
  }
}
