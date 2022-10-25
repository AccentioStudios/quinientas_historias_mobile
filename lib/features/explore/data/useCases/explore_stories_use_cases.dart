import '../../../../core/data/entities/story_entity.dart';
import '../repositories/explore_stories_repository.dart';

class ExploreStoriesUseCases {
  ExploreStoriesUseCases({required this.repository});
  final ExploreStoriesRepository repository;

  Stream<List<Story>> getStories() async* {
    yield* repository.getStories();
  }
}
