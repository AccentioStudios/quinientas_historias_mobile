part of 'reading_story_cubit.dart';

@freezed
class ReadingStoryState with _$ReadingStoryState {
  const factory ReadingStoryState(
      {required ReadingOptions readingOptions,
      @Default(false) bool loading,
      @Default(false) bool saveFavoriteloading,
      @Default(false) bool registeringQuizItem,
      @Default(false) bool notAskForRegisteringQuizItem,
      @Default(0) int storyProgress,
      Story? story,
      StoryRatings? myRating,
      @Default(false) bool quizFinished,
      @Default(0) int correctAnswers,
      Points? readPoints,
      @Default(0) int bonusTotalPoints,
      @Default(false) bool answerLoading,
      @Default(false) bool votingLikeDislikeLoading,
      String? publicEmail}) = _ReadingStoryState;
}
