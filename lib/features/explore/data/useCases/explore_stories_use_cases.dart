import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/data/models/list_page.dart';
import '../repositories/explore_stories_repository.dart';

class ExploreStoriesUseCases {
  ExploreStoriesUseCases({required this.repository});
  final ExploreStoriesRepository repository;

  Stream<ListPage<Story>> getStories({
    int? id,
    String? title,
    int? tournamentId,
    String? orderBy,
    int? pageKey,
  }) async* {
    yield* repository.getStories(
      id: id,
      title: title,
      tournamentId: tournamentId,
      orderBy: orderBy,
      pageKey: pageKey,
    );
  }
}
