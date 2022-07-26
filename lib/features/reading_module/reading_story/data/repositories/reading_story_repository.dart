import '../../../../../core/data/entities/story_progress_entity.dart';
import '../../../../../core/integrations/api_service/api_service.dart';
import '../models/set_progress_request.dart';
import '../models/set_story_progress_response.dart';

class ReadingStoryRepository with ApiService {
  Stream<StoryProgress> loadStory(int id) async* {
    yield* appApi
        .get('v1/stories/progress/$id')
        .handleJson(mapper: (data) => StoryProgress.fromJson(data));
  }

  Stream<SetStoryProgressResponse> setStoryProgress(
      SetStoryProgressRequest request) async* {
    yield* appApi
        .post('v1/stories/setProgress', data: request.toJson())
        .handleJson(mapper: (data) => SetStoryProgressResponse.fromMap(data));
  }
}
