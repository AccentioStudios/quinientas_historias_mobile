import '../../../../../core/data/dto/user_profile_dto.dart';
import '../repositories/user_profile_repository.dart';

class UserProfileUseCases {
  UserProfileUseCases({required this.repository});
  final UserProfileRepository repository;

  Stream<UserProfileDto> getUserProfile(int? userId) async* {
    yield* repository.getUserProfile(userId);
  }
}
