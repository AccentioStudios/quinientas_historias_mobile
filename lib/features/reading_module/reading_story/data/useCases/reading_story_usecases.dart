import 'package:quinientas_historias/core/data/models/save_favorite_request.dart';
import 'package:quinientas_historias/features/reading_module/reading_story/data/models/set_story_progress_request.dart';

import '../../../../../core/data/entities/story_progress_entity.dart';
import '../../../../../core/data/models/save_favorite_response.dart';
import '../models/reading_options_model.dart';
import '../models/set_story_progress_response.dart';
import '../repositories/reading_story_repository.dart';

class ReadingStoryUseCases {
  ReadingStoryUseCases({required this.repository});
  final ReadingStoryRepository repository;

  void saveReadingOptions(ReadingOptions newOptions) {
    return repository.saveReadingOptions(newOptions);
  }

  ReadingOptions loadReadingOptions() {
    return repository.loadReadingOptions();
  }

  Stream<StoryProgress> loadStory(int id) async* {
    yield* repository.loadStory(id);
  }

  Stream<SetStoryProgressResponse> setStoryProgress(
      SetStoryProgressRequest request) async* {
    yield* repository.setStoryProgress(request);
  }

  Stream<SaveFavoriteResponse> saveFavorite(
      SaveFavoriteRequest request) async* {
    yield* repository.saveFavorite(request);
  }
}
