// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'explore_stories_cubit.dart';

@freezed
class ExploreStoriesState with _$ExploreStoriesState {
  const factory ExploreStoriesState({
    @Default(true) isLoading,
    ListPage<Story>? listPage,
    @Default(ExploreSearchFilters()) ExploreSearchFilters filters,
  }) = _ExploreStoriesState;
}

class ExploreSearchFilters {
  const ExploreSearchFilters({
    this.id,
    this.title,
    this.tournamentId,
    this.orderBy,
  });

  final int? id;
  final String? title;
  final int? tournamentId;
  final String? orderBy;

  ExploreSearchFilters copyWith({
    int? id,
    String? title,
    int? tournamentId,
    String? orderBy,
  }) {
    return ExploreSearchFilters(
      id: id ?? this.id,
      title: title ?? this.title,
      tournamentId: tournamentId ?? this.tournamentId,
      orderBy: orderBy ?? this.orderBy,
    );
  }
}
