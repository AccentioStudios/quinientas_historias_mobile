import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/ui/widgets/link_button.dart';
import '../../../../../core/routes/auto_router.dart';
import '../../../../../core/ui/widgets/custom_inkwell.dart';
import '../../../../../core/ui/widgets/outlined_card.dart';

import '../../../../../core/data/entities/daily_challenge_entity.dart';
import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';

import '../../../../../core/ui/widgets/big_button.dart';

import '../../../../../core/ui/widgets/user_avatar.dart';
import '../../../../../core/utils/constants.dart';
import '../../data/entities/quiz_items.entity.dart';
import '../../data/models/set_story_progress_response.dart';

import '../bloc/cubit/reading_story_cubit.dart';

class ReadingStoryPostReadPage extends StatefulWidget {
  const ReadingStoryPostReadPage({
    super.key,
    required this.points,
    this.recomended,
    this.dailyChallenge,
    required this.user,
    this.quizItems,
  });

  final Points points;
  final List<Story>? recomended;
  final DailyChallenge? dailyChallenge;
  final User? user;
  final List<QuizItem>? quizItems;

  @override
  State<ReadingStoryPostReadPage> createState() =>
      _ReadingStoryPostReadPageState();
}

class _ReadingStoryPostReadPageState extends State<ReadingStoryPostReadPage> {
  final SwiperController _swiperController = SwiperController();
  int currentSwiperIndex = 0;
  bool showQuizSuccessScreen = false;

  @override
  void initState() {
    super.initState();
    _swiperController.addListener(() {
      setState(() {
        currentSwiperIndex = _swiperController.index;
      });
    });
  }

  @override
  void dispose() {
    _swiperController.removeListener(() {
      setState(() {
        currentSwiperIndex = _swiperController.index;
      });
    });
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadingStoryCubit, ReadingStoryState>(
      builder: (context, state) {
        bool quizActive =
            (widget.quizItems != null) && (widget.quizItems!.isNotEmpty);

        bool quizFinished = state.quizFinished;

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
                          height: 125 + MediaQuery.of(context).padding.top,
                        ),
                        UserAvatar(
                          user: widget.user!,
                          height: 110,
                          width: 110,
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
                  if (widget.quizItems != null)
                    if (widget.quizItems!.isNotEmpty)
                      showQuizSuccessScreen
                          ? _FinishedQuiz(state: state)
                          : QuizWidget(
                              quizItems: widget.quizItems!,
                              swiperController: _swiperController,
                            ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.space18,
                          vertical: Constants.space21),
                      child: !quizActive || quizFinished
                          ? BigButton(
                              text: getBigButtonLabel(state),
                              onPressed: () {
                                bigButtonOnPressed(state);
                              })
                          : const SizedBox.shrink(),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }

  void bigButtonOnPressed(ReadingStoryState state) {
    if (showQuizSuccessScreen) {
      AutoRouter.of(context).navigate(const HomeRoute());
    }
    if (state.quizFinished) {
      setState(() {
        showQuizSuccessScreen = true;
      });
      return;
    }
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

class QuizWidget extends StatefulWidget {
  const QuizWidget({
    super.key,
    required this.quizItems,
    required this.swiperController,
  });
  final List<QuizItem> quizItems;
  final SwiperController swiperController;

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  double height = 493;
  @override
  Widget build(BuildContext context) {
    return Swiper(
      scale: 1,
      controller: widget.swiperController,
      physics: const NeverScrollableScrollPhysics(),
      loop: false,
      itemCount: widget.quizItems.length,
      containerWidth: double.infinity,
      containerHeight: height + 10,
      itemWidth: double.infinity,
      itemHeight: height,
      layout: SwiperLayout.TINDER,
      itemBuilder: (BuildContext context, int index) {
        bool? questionAnsweredCorrectly = widget.quizItems[index].wasCorrect;
        return Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.space21, vertical: Constants.space21),
          width: MediaQuery.of(context).size.width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.primary,
          ),
          child: questionAnsweredCorrectly == true
              ? _SuccessAnswer(
                  onNext:
                      !_verifyIfAllQuizQuestionsAreFinished() ? _next : null,
                )
              : questionAnsweredCorrectly == false
                  ? _WrongAnswer(
                      correctAnswer: widget.quizItems[index].correctAnswer,
                      explanation: widget.quizItems[index].explanation,
                      onNext: !_verifyIfAllQuizQuestionsAreFinished()
                          ? _next
                          : null,
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.help_outline_outlined,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                                const SizedBox(width: Constants.space8),
                                Text('${index + 1}/${widget.quizItems.length}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary)),
                              ],
                            ),
                            FittedBox(
                              child: OutlinedCard(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Constants.space18,
                                  vertical: Constants.space8,
                                ),
                                borderRadius: Constants.borderRadius23,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        ' + ${widget.quizItems[index].points} ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondaryContainer)),
                                    Text(
                                      'Bonus',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondaryContainer,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        AutoSizeText.rich(
                          TextSpan(
                            text: widget.quizItems[index].question,
                          ),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        ListView.separated(
                          itemBuilder: (context, questionIndex) {
                            return CustomInkWell(
                              borderRadius: BorderRadius.circular(50),
                              backgroundColor: widget
                                          .quizItems[index].answered ==
                                      questionIndex
                                  ? questionAnsweredCorrectly == true
                                      ? const Color.fromRGBO(105, 251, 203, 1)
                                      : const Color.fromRGBO(255, 105, 105, 1)
                                  : Colors.transparent,
                              onTap: () {
                                _submit(questionIndex, index);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: Constants.space21),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.black),
                                ),
                                height: 50,
                                child: Center(
                                    child: AutoSizeText(
                                  widget
                                      .quizItems[index].options[questionIndex],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ),
                            );
                          },
                          itemCount: 4,
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: Constants.space21,
                            );
                          },
                        )
                      ],
                    ),
        );
      },
    );
  }

  _next() {
    widget.swiperController.next();
  }

  _submit(int answerIndex, int questionIndex) {
    final quizItem = widget.quizItems[questionIndex];

    // if (quizItem.answered != null) return;

    quizItem.answered = answerIndex;
    quizItem.wasCorrect =
        quizItem.options[answerIndex] == quizItem.correctAnswer;
    _updateQuizAnswers();

    if (_verifyIfAllQuizQuestionsAreFinished()) {
      _finishQuiz();
    }
  }

  bool _verifyIfAllQuizQuestionsAreFinished() {
    bool allQuestionsAnswered = true;
    for (var element in widget.quizItems) {
      if (element.answered == null) {
        allQuestionsAnswered = false;
      }
    }

    return allQuestionsAnswered;
  }

  _updateQuizAnswers() {
    context.read<ReadingStoryCubit>().updateQuizAnswers(widget.quizItems);
    setState(() {});
  }

  _finishQuiz() {
    final cubit = context.read<ReadingStoryCubit>();
    cubit.finishQuiz(widget.quizItems).then((_) {});
  }
}

class _WrongAnswer extends StatelessWidget {
  const _WrongAnswer({
    required this.correctAnswer,
    required this.explanation,
    this.onNext,
  });
  final String correctAnswer;
  final String explanation;
  final Function()? onNext;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          'assets/images/fail-check-image.svg',
          height: 74,
        ),
        const SizedBox(height: 22),
        AutoSizeText.rich(
          const TextSpan(
            text: '¡Casi! La respuesta era:',
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).colorScheme.onPrimary),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.space12, vertical: Constants.space12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          child: AutoSizeText.rich(
            TextSpan(text: correctAnswer),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onBackground),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 20),
        AutoSizeText.rich(
          TextSpan(text: explanation),
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.9)),
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 19),
        Container(
            width: 130,
            height: 1,
            color: Theme.of(context).colorScheme.onPrimary),
        const SizedBox(height: 25),
        // Region para votar like o dislike si les gustó la pregunta
        Column(
          children: [
            Text('Que te pareció la pregunta?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.thumb_up, color: Colors.green),
                    SizedBox(width: Constants.space41),
                    Icon(Icons.thumb_down, color: Colors.red),
                  ],
                ),
              ],
            ),
          ],
        ),
        // Next button
        const Spacer(),
        const SizedBox(height: 18),
        if (onNext != null)
          Align(
            alignment: Alignment.bottomCenter,
            child: LinkButton(
              text: 'Siguiente',
              height: 21,
              color: Theme.of(context).colorScheme.onPrimary,
              onTap: () {
                onNext!();
              },
            ),
          )
      ],
    );
  }
}

class _SuccessAnswer extends StatelessWidget {
  const _SuccessAnswer({
    this.onNext,
  });
  final Function()? onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        SvgPicture.asset(
          'assets/images/success-check-light-image.svg',
          height: 74,
        ),
        const SizedBox(height: 22),
        AutoSizeText.rich(
          const TextSpan(
            text: 'Felicidades',
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.7)),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        AutoSizeText.rich(
          const TextSpan(
            text: '¡Respondiste\ncorrectamente!',
          ),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 20),
        FittedBox(
          child: OutlinedCard(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.space18,
              vertical: Constants.space8,
            ),
            borderRadius: Constants.borderRadius23,
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(' + {points} ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondaryContainer)),
                Text(
                  'Bonus',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 50),
        Container(
            width: 130,
            height: 1,
            color: Theme.of(context).colorScheme.onPrimary),
        const SizedBox(height: 25),
        // Region para votar like o dislike si les gustó la pregunta
        Column(
          children: [
            Text('Que te pareció la pregunta?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.thumb_up, color: Colors.green),
                    SizedBox(width: Constants.space41),
                    Icon(Icons.thumb_down, color: Colors.red),
                  ],
                ),
              ],
            ),
          ],
        ),
        // Next button
        const Spacer(),
        const SizedBox(height: 18),
        if (onNext != null)
          Align(
            alignment: Alignment.bottomCenter,
            child: LinkButton(
              text: 'Siguiente',
              height: 21,
              color: Theme.of(context).colorScheme.onPrimary,
              onTap: () {
                onNext!();
              },
            ),
          )
      ],
    );
  }
}

class _FinishedQuiz extends StatelessWidget {
  const _FinishedQuiz({required this.state});

  final ReadingStoryState state;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.space21, vertical: Constants.space21),
        width: MediaQuery.of(context).size.width,
        height: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/success-check-light-image.svg',
              height: 74,
            ),
            const SizedBox(height: 22),
            AutoSizeText.rich(
              const TextSpan(
                text: 'Felicidades',
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color:
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.7)),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            AutoSizeText.rich(
              const TextSpan(
                text: '¡Terminaste el quiz!',
              ),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 20),
            FittedBox(
              child: OutlinedCard(
                padding: const EdgeInsets.symmetric(
                  horizontal: Constants.space18,
                  vertical: Constants.space8,
                ),
                borderRadius: Constants.borderRadius23,
                backgroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer,
                child: Column(
                  children: [
                    if (state.readPoints != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              ' + ${state.readPoints!.base + state.readPoints!.bonus} ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer)),
                          Text(
                            'Puntos',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                          )
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(' + ${state.bonusTotalPoints} ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer)),
                        Text(
                          'Bonus',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class _BackgroundGradient extends StatelessWidget {
  const _BackgroundGradient();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
