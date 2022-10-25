part of 'explore_stories_cubit.dart';

@freezed
class ExploreStoriesState with _$ExploreStoriesState {
  const factory ExploreStoriesState({
    @Default(true) isLoading,
    @Default(initState) List<Story> exploreStories,
  }) = _ExploreStoriesState;
}

const List<Story> initState = [];
