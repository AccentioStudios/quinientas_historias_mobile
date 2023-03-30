import '../../../../core/data/entities/user_entity.dart';
import '../entities/dashboard_entity.dart';
import '../repositories/home_repository.dart';

class HomeUseCases {
  HomeUseCases({required this.repository});
  final HomeRepository repository;

  Stream<User> userData() async* {
    yield* repository.userData();
  }

  Stream<Dashboard> getDashboard() async* {
    yield* repository.getDashboard();
  }
}
