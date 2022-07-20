import '../../../../../core/data/entities/story_progress_entity.dart';
import '../repositories/reading_story_repository.dart';

class ReadingStoryUseCases {
  ReadingStoryUseCases({required this.repository});
  final ReadingStoryRepository repository;

  Stream<StoryProgress> loadStory(int id) async* {
    yield* repository.loadStory(id);
  }
}
