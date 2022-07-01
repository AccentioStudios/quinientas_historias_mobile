import 'package:quinientas_historias/features/home/data/entities/dashboard_entity.dart';

import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/data/entities/user_entity.dart';
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

  Stream<List<Story>> getStories() async* {
    yield* repository.getStories();
  }
}
