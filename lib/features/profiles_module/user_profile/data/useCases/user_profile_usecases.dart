import '../models/user_profile_model.dart';
import '../repositories/user_profile_repository.dart';

class UserProfileUseCases {
  UserProfileUseCases({required this.repository});
  final UserProfileRepository repository;

  Stream<UserProfile> getUserProfile(int userId) async* {
    yield* repository.getUserProfile(userId);
  }
}
