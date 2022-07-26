part of 'reading_story_cubit.dart';

@freezed
class ReadingStoryState with _$ReadingStoryState {
  const factory ReadingStoryState({
    @Default(false) bool loading,
    @Default(0) int storyProgress,
    Story? story,
  }) = _ReadingStoryState;
}
