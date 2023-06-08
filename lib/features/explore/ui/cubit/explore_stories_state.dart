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
