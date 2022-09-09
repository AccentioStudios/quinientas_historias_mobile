import 'package:quinientas_historias/core/helpers/shared_preferences_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/data/entities/story_progress_entity.dart';
import '../../../../../core/data/models/save_favorite_request.dart';
import '../../../../../core/data/models/save_favorite_response.dart';
import '../../../../../core/integrations/api_service/api_service.dart';

import '../models/reading_options_model.dart';
import '../models/set_story_progress_request.dart';
import '../models/set_story_progress_response.dart';

class ReadingStoryRepository with ApiService {
  void saveReadingOptions(ReadingOptions newOptions) {
    final instance = SharedPreferencesHelper.instance;
    instance.setString('readingOptions', newOptions.toJson().toString());
  }

  ReadingOptions loadReadingOptions() {
    final instance = SharedPreferencesHelper.instance;
    final String? readingOptions = instance.getString('readingOptions');
    if (readingOptions != null) {
      return ReadingOptions.fromJson(
          instance.getString('readingOptions') as Map<String, dynamic>);
    }
    return ReadingOptions();
  }

  Stream<StoryProgress> loadStory(int id) async* {
    yield* appApi
        .get('v1/stories/progress/$id')
        .handleJson(mapper: (data) => StoryProgress.fromJson(data));
  }

  Stream<SetStoryProgressResponse> setStoryProgress(
      SetStoryProgressRequest request) async* {
    yield* appApi
        .post('v1/stories/setProgress', data: request.toJson())
        .handleJson(mapper: (data) => SetStoryProgressResponse.fromJson(data));
  }

  Stream<SetStoryProgressResponse> completeStory(
      SetStoryProgressRequest request) async* {
    yield* appApi
        .post('v1/stories/completeStory', data: request.toJson())
        .handleJson(mapper: (data) => SetStoryProgressResponse.fromJson(data));
  }

  Stream<SaveFavoriteResponse> saveFavorite(
      SaveFavoriteRequest request) async* {
    yield* appApi
        .post('v1/stories/saveFavorite', data: request.toJson())
        .handleJson(mapper: (data) => SaveFavoriteResponse.fromMap(data));
  }
}
