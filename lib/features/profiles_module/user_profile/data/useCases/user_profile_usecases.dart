import '../../../../../core/data/entities/user_entity.dart';
import '../repositories/user_profile_repository.dart';

class UserProfileUseCases {
  UserProfileUseCases({required this.repository});
  final UserProfileRepository repository;

  Stream<User> getUserProfile(int? userId) async* {
    yield* repository.getUserProfile(userId);
  }
}
