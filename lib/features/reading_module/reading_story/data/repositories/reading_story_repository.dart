import '../../../../../core/data/entities/story_progress_entity.dart';
import '../../../../../core/integrations/api_service/api_service.dart';

class ReadingStoryRepository with ApiService {
  Stream<StoryProgress> loadStory(int id) async* {
    yield* appApi
        .get('v1/stories/progress/$id')
        .handleJson(mapper: (data) => StoryProgress.fromJson(data));
  }
}
