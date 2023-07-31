import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/mixins/bottom_sheet_messages.dart';
import 'package:quinientas_historias/core/ui/widgets/role_widget.dart';
import 'package:quinientas_historias/features/quiz/quiz_provider.dart';
import 'package:quinientas_historias/features/reading_module/reading_story/reading_story_provider.dart';
import '../../../../../core/routes/auto_router.dart';
import '../../../../../core/ui/widgets/outlined_card.dart';

import '../../../../../core/data/entities/daily_challenge_entity.dart';
import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';

import '../../../../../core/ui/widgets/big_button.dart';

import '../../../../../core/ui/widgets/user_avatar.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../quiz/domain/entities/quiz_items.entity.dart';
import '../../data/models/set_story_progress_response.dart';

import '../bloc/cubit/reading_story_cubit.dart';

class ReadingStoryPostReadPage extends StatefulWidget with SheetMessages {
  const ReadingStoryPostReadPage(
      {super.key,
      required this.points,
      this.recomended,
      this.dailyChallenge,
      required this.user,
      this.quizItems,
      required this.story});

  final Points points;
  final List<Story>? recomended;
  final DailyChallenge? dailyChallenge;
  final User? user;
  final List<QuizItem>? quizItems;
  final Story story;

  @override
  State<ReadingStoryPostReadPage> createState() =>
      _ReadingStoryPostReadPageState();
}

class _ReadingStoryPostReadPageState extends State<ReadingStoryPostReadPage> {
  @override
  void initState() {
    _verifyIfHasQuizItems(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadingStoryCubit, ReadingStoryState>(
      builder: (context, state) {
        return WillPopScope(
            onWillPop: () async {
              return true;
            },
            child: Scaffold(
              body: Stack(
                children: [
                  const _BackgroundGradient(),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 125 + MediaQuery.paddingOf(context).top,
                        ),
                        widget.user != null
                            ? UserAvatar(
                                user: widget.user!,
                                height: 110,
                                width: 110,
                              )
                            : SizedBox(
                                width: 137,
                                child: Image.asset('assets/images/logo.png'),
                              ),
                        const SizedBox(
                          height: Constants.space21,
                        ),
                        const Text(
                          "Completaste una lectura",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: Constants.space12,
                        ),
                        const Text(
                          "¡Sigue así!",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: Constants.space16,
                        ),
                        if (widget.points.base > 0)
                          FittedBox(
                            child: OutlinedCard(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Constants.space18,
                                vertical: Constants.space8,
                              ),
                              borderRadius: Constants.borderRadius23,
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(105, 251, 203, 1)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/points-icon.svg',
                                        height: Constants.space16,
                                        color: const Color.fromRGBO(
                                            105, 251, 203, 1),
                                      ),
                                      Text(' + ${widget.points.base} ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  105, 251, 203, 1))),
                                      const Text(
                                        'Puntos',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(105, 251, 203, 1),
                                        ),
                                      )
                                    ],
                                  ),
                                  if (widget.points.bonus > 0)
                                    const SizedBox(height: Constants.space8),
                                  if (widget.points.bonus > 0)
                                    Text(
                                      '+ ${widget.points.bonus} bonus',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(105, 251, 203, 1),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ),
                        if (widget.dailyChallenge != null)
                          const Padding(
                            padding: EdgeInsets.only(top: Constants.space41),
                            child: Text(
                              'Escoge tu siguiente lectura: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                      ],
                    ),
                  ),
                  RoleWidget(
                    roles: const [
                      Role.admin,
                      Role.reader,
                      Role.captain,
                      Role.prof,
                    ],
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.space18,
                              vertical: Constants.space21),
                          child: BigButton(
                              text: getBigButtonLabel(state),
                              onPressed: () {
                                bigButtonOnPressed(
                                    state, context.read<ReadingStoryCubit>());
                              })),
                    ),
                  ),
                  RoleWidget(
                    forPublic: true,
                    roles: const [],
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.space18,
                              vertical: Constants.space21),
                          child: BigButton(
                              text: 'Ver otras historias',
                              onPressed: () {
                                AutoRouter.of(context)
                                    .pushNamed('/tournaments/p');
                              })),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  _verifyIfHasQuizItems(BuildContext context) {
    if (widget.quizItems != null && widget.quizItems!.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 300)).then((value) {
        QuizProvider.openQuiz(context, quizItems: widget.quizItems!,
            onPressedSeeStory: () {
          ReadingStoryProvider.openStory(context,
              storyId: widget.story.id, isQuickView: true);
        });
      });
    }
  }

  void bigButtonOnPressed(
      ReadingStoryState state, ReadingStoryCubit cubit) async {
    var wantToAdd = false;
    if (state.notAskForRegisteringQuizItem != true) {
      wantToAdd = await widget.showAddQuizItemQuestion(context);
    }

    if (wantToAdd == true) {
      if (!mounted) return;
      cubit.notAskForRegisteringQuizItem();
      QuizProvider.openRegisterNewQuizItem(context, story: widget.story);

      return;
    } else if (wantToAdd == false) {
      cubit.notAskForRegisteringQuizItem();
    }

    // if (showQuizSuccessScreen) {
    //   if (!mounted) return;
    //   AutoRouter.of(context).navigate(const HomeRoute());
    // }
    // if (state.quizFinished) {
    //   setState(() {
    //     showQuizSuccessScreen = true;
    //   });
    //   return;
    // }
    if (!mounted) return;
    AutoRouter.of(context).navigate(const HomeRoute());
  }

  String getBigButtonLabel(ReadingStoryState state) {
    if (state.quizFinished) {
      return 'Continuar';
    }
    if (widget.recomended != null) {
      return 'Leer otra historia';
    }
    return 'Ir al home';
  }
}

class _BackgroundGradient extends StatelessWidget {
  const _BackgroundGradient();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const RadialGradient(
          center: Alignment(0, 0),
          colors: [
            Color.fromRGBO(8, 69, 136, 1),
            Color.fromRGBO(16, 28, 41, 1)
          ],
        ),
      ),
    );
  }

  int calculatePercentage(int? total, int? current) {
    if (total != null && current != null) {
      if (total > 0) {
        return (current * 100 ~/ total).toInt();
      }
      return 0;
    }
    return 0;
  }

  // void _navigateToStoryPage(
  //   BuildContext context,
  //   Story story,
  // ) {
  //   Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
  //       builder: (_) => ReadingStoryProvider(
  //             storyId: story.id,
  //           )));
  // }
}
