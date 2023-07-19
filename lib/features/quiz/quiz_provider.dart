import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/features/quiz/data/repositories/quiz_item_repository.dart';
import 'package:quinientas_historias/features/quiz/domain/bloc/cubit/quiz_cubit.dart';
import 'package:quinientas_historias/features/quiz/ui/pages/register_quiz_item_page.dart';
import 'package:quinientas_historias/features/quiz/ui/widgets/quiz_pop_up_route_page.dart';
import 'package:quinientas_historias/features/quiz/ui/widgets/quiz_widget.dart';

import '../../core/data/entities/story_entity.dart';
import 'domain/entities/quiz_items.entity.dart';

@RoutePage<bool?>()
class QuizProvider extends StatelessWidget {
  const QuizProvider(
      {super.key, required this.quizItems, required this.onPressedSeeStory});
  final List<QuizItem> quizItems;
  final Function()? onPressedSeeStory;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(
        quizItems: quizItems,
        repository: QuizRepository(),
      ),
      child: QuizWidget(onPressedSeeStory: onPressedSeeStory),
    );
  }

  static Future<bool?> openRegisterNewQuizItem(
    BuildContext context, {
    required Story story,
  }) {
    return Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => BlocProvider(
                create: (context) => QuizCubit(
                  quizItems: [],
                  repository: QuizRepository(),
                ),
                child: RegisterQuizItemPage(
                  story: story,
                ),
              )),
    );
  }

  static Future<bool?> openQuiz(
    BuildContext context, {
    required List<QuizItem> quizItems,
    required final void Function()? onPressedSeeStory,
    bool rootNavigator = true,
  }) {
    return Navigator.of(context, rootNavigator: rootNavigator).push<bool>(
      QuizPopupRoute<bool>(
        builder: (context) => QuizProvider(
            quizItems: quizItems, onPressedSeeStory: onPressedSeeStory),
      ),
    );
  }
}
