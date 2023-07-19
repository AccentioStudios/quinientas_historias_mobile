part of 'quiz_cubit.dart';

@freezed
class QuizState with _$QuizState {
  const factory QuizState({
    @Default(false) bool registeringQuizItem,
    @Default(false) bool notAskForRegisteringQuizItem,
    @Default(false) bool quizFinished,
    @Default(0) int correctAnswers,
    Points? readPoints,
    @Default(0) int bonusTotalPoints,
    @Default(false) bool answerLoading,
    @Default(false) bool votingLikeDislikeLoading,
    @Default(false) bool approvingQuizItemLoading,
    required List<QuizItem> quizItems,
  }) = _QuizState;
}
