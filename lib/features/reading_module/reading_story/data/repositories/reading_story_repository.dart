import 'dart:convert';

import '../../../../../core/data/entities/story_progress_entity.dart';
import '../../../../../core/data/models/rate_story_request.dart';
import '../../../../../core/data/models/save_favorite_request.dart';
import '../../../../../core/helpers/shared_preferences_helper.dart';
import '../../../../../core/integrations/api_service.dart';
import '../models/reading_options_model.dart';
import '../models/set_story_progress_request.dart';
import '../models/set_story_progress_response.dart';

class ReadingStoryRepository with ApiService {
  void saveReadingOptions(ReadingOptions newOptions) {
    final instance = SharedPreferencesHelper.instance;
    instance.setString('readingOptions', json.encode(newOptions.toJson()));
  }

  ReadingOptions loadReadingOptions() {
    final instance = SharedPreferencesHelper.instance;
    final String? readingOptions = instance.getString('readingOptions');
    if (readingOptions != null) {
      try {
        return ReadingOptions.fromJson(json.decode(readingOptions));
      } catch (error) {
        return ReadingOptions();
      }
    }
    return ReadingOptions();
  }

  Stream<StoryProgress> loadStory(int id) async* {
    yield* appApi
        .get('v2/story/progress/$id')
        .handleJson(mapper: (data) => StoryProgress.fromJson(data));
  }

  Stream<SetStoryProgressResponse> setStoryProgress(
      UpdateStoryProgressDto request) async* {
    yield* appApi
        .post('v2/story/progress', data: request.toJson())
        .handleJson(mapper: (data) => SetStoryProgressResponse.fromJson(data));
  }

  Stream<SetStoryProgressResponse> completeStory(
      UpdateStoryProgressDto request) async* {
    yield* appApi
        .post('v2/story/progress', data: request.toJson())
        .handleJson(mapper: (data) => SetStoryProgressResponse.fromJson(data));
  }

  Stream<void> saveFavorite(SaveFavoriteRequest request) async* {
    yield* appApi.post('v2/favorite', data: request.toJson()).handleJson(
        mapper: (data) {
      return;
    });
  }

  Stream<void> removeFavorite(int storyId) async* {
    yield* appApi.delete('v2/favorite/$storyId').handleJson(mapper: (data) {
      return;
    });
  }

  Stream<void> rateStory(int id, RateStoryRequest request) async* {
    yield* appApi.post('v2/story/rate/$id', data: request.toJson()).handleJson(
        mapper: (data) {
      return;
    });
  }
}
