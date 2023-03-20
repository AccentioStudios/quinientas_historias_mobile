import '../../../../../core/data/models/save_favorite_request.dart';
import '../models/set_story_progress_request.dart';

import '../../../../../core/data/entities/story_progress_entity.dart';
import '../../../../../core/data/models/rate_story_request.dart';
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
      UpdateStoryProgressDto request) async* {
    yield* repository.setStoryProgress(request);
  }

  Stream<SetStoryProgressResponse> completeStory(
      UpdateStoryProgressDto request) async* {
    yield* repository.completeStory(request);
  }

  Stream<void> saveFavorite(SaveFavoriteRequest request) async* {
    yield* repository.saveFavorite(request);
  }

  Stream<void> removeFavorite(int storyId) async* {
    yield* repository.removeFavorite(storyId);
  }

  Stream<void> rateStory(int id, RateStoryRequest request) async* {
    yield* repository.rateStory(id, request);
  }
}
