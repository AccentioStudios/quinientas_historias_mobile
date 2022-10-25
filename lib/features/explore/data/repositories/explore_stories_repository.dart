import 'dart:convert';

import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/integrations/api_service.dart';

class ExploreStoriesRepository with ApiService {
  Stream<List<Story>> getStories() async* {
    yield* appApi.get('/v1/invites').handle(
        mapper: (Object data) =>
            json.decode(data as String).map<Story>((dynamic jsonMap) {
              return Story.fromJson(jsonMap as Map<String, dynamic>);
            }).toList());
  }
}
