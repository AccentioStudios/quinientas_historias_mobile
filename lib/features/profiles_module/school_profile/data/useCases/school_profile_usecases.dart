import '../../../../../core/data/entities/school_entity.dart';
import '../repositories/school_profile_repository.dart';

class SchoolProfileUseCases {
  SchoolProfileUseCases({required this.repository});
  final SchoolProfileRepository repository;

  Stream<School> getSchool(int schoolId) async* {
    yield* repository.getSchoolProfile(schoolId);
  }
}
