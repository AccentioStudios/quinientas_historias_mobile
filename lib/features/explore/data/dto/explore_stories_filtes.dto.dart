import '../../../../core/data/entities/story_entity.dart';

class ExploreSearchFilters {
  const ExploreSearchFilters({
    this.id,
    this.title,
    this.tournamentId,
    this.orderBy = StoryOrderBy.niceRating,
  });

  final int? id;
  final String? title;
  final int? tournamentId;
  final StoryOrderBy orderBy;

  ExploreSearchFilters copyWith({
    int? id,
    String? title,
    int? tournamentId,
    StoryOrderBy? orderBy,
  }) {
    return ExploreSearchFilters(
      id: id ?? this.id,
      title: title ?? this.title,
      tournamentId: tournamentId ?? this.tournamentId,
      orderBy: orderBy ?? this.orderBy,
    );
  }
}
