import '../../../../../core/integrations/api_service.dart';
import '../../domain/dto/approve_disapprove_quiz_item.dto.dart';
import '../../domain/dto/like_dislike_quiz_item.dto.dart';
import '../../domain/entities/quiz_items.entity.dart';

class QuizRepository with ApiService {
  Stream<void> verifyAndSaveUserAnswer(QuizItem quizItem) async* {
    yield* appApi.post('v2/quiz/answer', data: quizItem.toJson()).handle(
        mapper: (data) {
      return;
    });
  }

  Stream<void> registerQuizItem(QuizItem quizItem) async* {
    yield* appApi.post('v2/quiz', data: quizItem.toJson()).handle(
        mapper: (data) {
      return;
    });
  }

  Stream<void> voteLikeOrDislike(
      int quizItemId, LikeDislikeQuizItemDto dto) async* {
    yield* appApi.post('v2/quiz/vote/$quizItemId', data: dto.toJson()).handle(
        mapper: (data) {
      return;
    });
  }

  Stream<void> approveOrDisapproveQuizItem(
      int quizItemId, ApproveDisapproveQuizItemDto dto) async* {
    yield* appApi
        .post('v2/quiz/approve/$quizItemId', data: dto.toJson())
        .handle(mapper: (data) {
      return;
    });
  }
}
