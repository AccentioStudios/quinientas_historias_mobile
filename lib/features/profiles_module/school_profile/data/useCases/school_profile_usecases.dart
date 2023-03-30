import '../../../../../core/data/dto/school_profile_dto.dart';
import '../repositories/school_profile_repository.dart';

class SchoolProfileUseCases {
  SchoolProfileUseCases({required this.repository});
  final SchoolProfileRepository repository;

  Stream<SchoolProfileDto> getSchool(int schoolId) async* {
    yield* repository.getSchoolProfile(schoolId);
  }
}
