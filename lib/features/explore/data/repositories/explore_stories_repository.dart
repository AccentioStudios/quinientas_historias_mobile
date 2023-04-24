import 'dart:convert';

import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/data/models/list_page.dart';
import '../../../../core/integrations/api_service.dart';

class ExploreStoriesRepository with ApiService {
  Stream<ListPage<Story>> getStories({
    int? id,
    String? title,
    int? tournamentId,
    String? orderBy,
    int? pageKey,
  }) async* {
    yield* appApi.get('/v2/story/search', queryParameters: {
      'id': id?.toString(),
      'title': title,
      'tournamentId': tournamentId?.toString(),
      'orderBy': orderBy,
      'page': pageKey?.toString(),
    }).handle(mapper: (data) {
      final stories = ((data as dynamic)['itemList'] as List<dynamic>)
          .map<Story>((dynamic item) {
        return Story.fromJson(item as Map<String, dynamic>);
      }).toList();

      return ListPage<Story>(
        grandTotalCount: (data as dynamic)['grandTotalCount'],
        itemList: stories,
      );
    });
  }
}
