import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../../core/mixins/stream_disposable.dart';
import '../../../../reading_module/reading_story/data/models/set_story_progress_response.dart';
import '../../../data/repositories/quiz_item_repository.dart';
import '../../dto/approve_disapprove_quiz_item.dto.dart';
import '../../dto/like_dislike_quiz_item.dto.dart';
import '../../entities/quiz_items.entity.dart';

part 'quiz_cubit.freezed.dart';
part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> with StreamDisposable {
  QuizCubit({required this.repository, required this.quizItems})
      : super(QuizState(quizItems: quizItems));

  final QuizRepository repository;
  final List<QuizItem> quizItems;

  updateQuizAnswers(List<QuizItem> quizItems) {
    emit(state.copyWith(quizItems: quizItems));
  }

  notAskForRegisteringQuizItem() {
    emit(state.copyWith(notAskForRegisteringQuizItem: true));
  }

  Future<void> finishQuiz(List<QuizItem> quizItems) async {
    final Completer<void> completer = Completer<void>();
    int correctAnswers = 0;
    int totalPoints = 0;
    try {
      for (var element in quizItems) {
        final bool verify = await verifyAndSaveUserAnswer(element);
        if (element.wasCorrect == true && verify == true) {
          correctAnswers++;
          totalPoints += element.points;
        }
      }
      emit(state.copyWith(
          quizFinished: true,
          correctAnswers: correctAnswers,
          bonusTotalPoints: totalPoints,
          quizItems: quizItems));
      completer.complete();
    } catch (error) {
      completer.completeError(error);
    }
    return completer.future;
  }

  Future<bool> verifyAndSaveUserAnswer(QuizItem quizItem) {
    final Completer<bool> completer = Completer<bool>();
    emit(state.copyWith(answerLoading: true));
    repository.verifyAndSaveUserAnswer(quizItem).listen((_) {
      emit(state.copyWith(answerLoading: false));
      completer.complete(true);
    }, onError: (error) {
      emit(state.copyWith(answerLoading: false));
      completer.completeError(error);
    }).subscribe(this);

    return completer.future;
  }

  Future<bool> registerQuizItem({
    required String question,
    required String correctAnswer,
    required String explanation,
    required String incorrectAnswer1,
    required String incorrectAnswer2,
    required String incorrectAnswer3,
    required int storyId,
    int points = 15,
  }) async {
    final Completer<bool> completer = Completer<bool>();

    emit(state.copyWith(registeringQuizItem: true));

    final QuizItem quizItem = QuizItem(
      points: points,
      question: question,
      correctAnswer: correctAnswer,
      options: [
        correctAnswer,
        incorrectAnswer1,
        incorrectAnswer2,
        incorrectAnswer3
      ]..shuffle(),
      storyId: storyId,
      explanation: explanation,
    );

    repository.registerQuizItem(quizItem).listen((_) {
      emit(state.copyWith(registeringQuizItem: false));
      completer.complete(true);
    }, onError: (error) {
      emit(state.copyWith(registeringQuizItem: false));
      completer.completeError(error);
    }).subscribe(this);
    return completer.future;
  }

  Future<bool> voteLikeOrDislike(int quizItemId, bool liked) {
    final Completer<bool> completer = Completer<bool>();
    emit(state.copyWith(votingLikeDislikeLoading: true));

    final dto = LikeDislikeQuizItemDto(
      liked: liked,
    );

    repository.voteLikeOrDislike(quizItemId, dto).listen((_) {
      emit(state.copyWith(votingLikeDislikeLoading: false));
      completer.complete(true);
    }, onError: (error) {
      emit(state.copyWith(votingLikeDislikeLoading: false));
      completer.completeError(error);
    }).subscribe(this);

    return completer.future;
  }

  Future<bool> approveOrDisapproveQuizItem(bool approved, int quizItemId) {
    final Completer<bool> completer = Completer<bool>();
    emit(state.copyWith(approvingQuizItemLoading: true));

    final dto = ApproveDisapproveQuizItemDto(
      approved: approved,
    );

    repository.approveOrDisapproveQuizItem(quizItemId, dto).listen((_) {
      emit(state.copyWith(approvingQuizItemLoading: false));
      completer.complete(true);
    }, onError: (error) {
      emit(state.copyWith(approvingQuizItemLoading: false));
      completer.completeError(error);
    }).subscribe(this);

    return completer.future;
  }
}
