import 'package:quinientas_historias/features/reading_module/reading_story/data/models/set_progress_request.dart';

import '../../../../../core/data/entities/story_progress_entity.dart';
import '../models/set_story_progress_response.dart';
import '../repositories/reading_story_repository.dart';

class ReadingStoryUseCases {
  ReadingStoryUseCases({required this.repository});
  final ReadingStoryRepository repository;

  Stream<StoryProgress> loadStory(int id) async* {
    yield* repository.loadStory(id);
  }

  Stream<SetStoryProgressResponse> setStoryProgress(
      SetStoryProgressRequest request) async* {
    yield* repository.setStoryProgress(request);
  }
}
