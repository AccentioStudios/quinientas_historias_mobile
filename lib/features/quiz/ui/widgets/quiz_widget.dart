import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quinientas_historias/core/utils/colors.dart';

import '../../../../core/ui/widgets/big_button.dart';
import '../../../../core/ui/widgets/custom_inkwell.dart';
import '../../../../core/ui/widgets/link_button.dart';
import '../../../../core/ui/widgets/outlined_card.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/bloc/cubit/quiz_cubit.dart';
import '../../domain/entities/quiz_items.entity.dart';

class QuizWidget extends StatefulWidget {
  const QuizWidget({
    super.key,
    required this.onPressedSeeStory,
  });

  final void Function()? onPressedSeeStory;

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  final CardSwiperController _swiperController = CardSwiperController();
  int currentSwiperIndex = 0;
  bool showQuizSuccessScreen = false;
  double height = 493;
  bool quizEnded = false;

  @override
  void initState() {
    super.initState();
    _swiperController.addListener(() {
      setState(() {
        currentSwiperIndex = _swiperController.state?.index ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _swiperController.removeListener(() {
      setState(() {
        currentSwiperIndex = _swiperController.state?.index ?? 0;
      });
    });
    _swiperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        List<Container> cards = [
          ...state.quizItems.asMap().entries.map((entry) {
            int index = entry.key;
            QuizItem item = entry.value;

            bool? questionAnsweredCorrectly = item.wasCorrect;
            bool? liked = item.liked;
            return Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.space21, vertical: Constants.space21),
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: questionAnsweredCorrectly == true
                  ? _SuccessAnswer(
                      onLoading: state.votingLikeDislikeLoading,
                      liked: liked,
                      likeOrDislike: (liked) {
                        _voteLikeOrDislike(
                          item.id!,
                          liked,
                          index,
                          state,
                        );
                      },
                      points: item.points,
                      onNext: !_verifyIfAllQuizQuestionsAreFinished(state)
                          ? _next
                          : null,
                    )
                  : questionAnsweredCorrectly == false
                      ? _WrongAnswer(
                          onLoading: state.votingLikeDislikeLoading,
                          liked: liked,
                          likeOrDislike: (liked) {
                            _voteLikeOrDislike(item.id!, liked, index, state);
                          },
                          correctAnswer: item.correctAnswer,
                          explanation: item.explanation,
                          onNext: !_verifyIfAllQuizQuestionsAreFinished(state)
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                    const SizedBox(width: Constants.space8),
                                    Text(
                                        '${index + 1}/${state.quizItems.length}',
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(' + ${item.points} ',
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
                                text: item.question,
                              ),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            ListView.separated(
                              itemBuilder: (context, questionIndex) {
                                return CustomInkWell(
                                  borderRadius: BorderRadius.circular(50),
                                  backgroundColor:
                                      item.answered == questionIndex
                                          ? questionAnsweredCorrectly == true
                                              ? const Color.fromRGBO(
                                                  105, 251, 203, 1)
                                              : const Color.fromRGBO(
                                                  255, 105, 105, 1)
                                          : Colors.transparent,
                                  onTap: () {
                                    _submit(questionIndex, index, state);
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
                                      item.options[questionIndex],
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
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  height: Constants.space21,
                                );
                              },
                            )
                          ],
                        ),
            );
          }).toList(),
          Container(),
        ];

        return showQuizSuccessScreen
            ? _FinishedQuiz(state: state)
            : Column(
                children: [
                  SizedBox(
                    height: height + 10,
                    child: CardSwiper(
                        allowedSwipeDirection:
                            const AllowedSwipeDirection.none(),
                        cardsCount: cards.length,
                        cardBuilder: (context, index, percentThresholdX,
                                percentThresholdY) =>
                            cards[index]),
                  ),
                  // Swiper(
                  //   scale: 1,
                  //   controller: _swiperController,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   loop: true,
                  //   itemCount: state.quizItems.length,
                  //   containerHeight: height + 10,
                  //   containerWidth: width,
                  //   itemHeight: height,
                  //   itemWidth: width - 42,
                  //   layout: SwiperLayout.STACK,
                  //   itemBuilder: (BuildContext context, int index) {
                  //     bool? questionAnsweredCorrectly =
                  //         state.quizItems[index].wasCorrect;

                  //     bool? liked = state.quizItems[index].liked;
                  //     return Container(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: Constants.space21,
                  //           vertical: Constants.space21),
                  //       width: MediaQuery.sizeOf(context).width,
                  //       height: height,
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(20),
                  //         color: Theme.of(context).colorScheme.primary,
                  //       ),
                  //       child: questionAnsweredCorrectly == true
                  //           ? _SuccessAnswer(
                  //               onLoading: state.votingLikeDislikeLoading,
                  //               liked: liked,
                  //               likeOrDislike: (liked) {
                  //                 _voteLikeOrDislike(
                  //                   state.quizItems[index].id!,
                  //                   liked,
                  //                   index,
                  //                   state,
                  //                 );
                  //               },
                  //               points: state.quizItems[index].points,
                  //               onNext:
                  //                   !_verifyIfAllQuizQuestionsAreFinished(state)
                  //                       ? _next
                  //                       : null,
                  //             )
                  //           : questionAnsweredCorrectly == false
                  //               ? _WrongAnswer(
                  //                   onLoading: state.votingLikeDislikeLoading,
                  //                   liked: liked,
                  //                   likeOrDislike: (liked) {
                  //                     _voteLikeOrDislike(
                  //                         state.quizItems[index].id!,
                  //                         liked,
                  //                         index,
                  //                         state);
                  //                   },
                  //                   correctAnswer:
                  //                       state.quizItems[index].correctAnswer,
                  //                   explanation:
                  //                       state.quizItems[index].explanation,
                  //                   onNext:
                  //                       !_verifyIfAllQuizQuestionsAreFinished(
                  //                               state)
                  //                           ? _next
                  //                           : null,
                  //                 )
                  //               : Column(
                  //                   children: [
                  //                     Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.spaceBetween,
                  //                       children: [
                  //                         Row(
                  //                           children: [
                  //                             Icon(
                  //                               Icons.help_outline_outlined,
                  //                               color: Theme.of(context)
                  //                                   .colorScheme
                  //                                   .onPrimary,
                  //                             ),
                  //                             const SizedBox(
                  //                                 width: Constants.space8),
                  //                             Text(
                  //                                 '${index + 1}/${state.quizItems.length}',
                  //                                 style: TextStyle(
                  //                                     fontWeight:
                  //                                         FontWeight.bold,
                  //                                     color: Theme.of(context)
                  //                                         .colorScheme
                  //                                         .onPrimary)),
                  //                           ],
                  //                         ),
                  //                         FittedBox(
                  //                           child: OutlinedCard(
                  //                             padding:
                  //                                 const EdgeInsets.symmetric(
                  //                               horizontal: Constants.space18,
                  //                               vertical: Constants.space8,
                  //                             ),
                  //                             borderRadius:
                  //                                 Constants.borderRadius23,
                  //                             backgroundColor: Theme.of(context)
                  //                                 .colorScheme
                  //                                 .tertiaryContainer,
                  //                             child: Row(
                  //                               mainAxisAlignment:
                  //                                   MainAxisAlignment.center,
                  //                               children: [
                  //                                 Text(
                  //                                     ' + ${state.quizItems[index].points} ',
                  //                                     style: TextStyle(
                  //                                         fontWeight:
                  //                                             FontWeight.bold,
                  //                                         color: Theme.of(
                  //                                                 context)
                  //                                             .colorScheme
                  //                                             .onSecondaryContainer)),
                  //                                 Text(
                  //                                   'Bonus',
                  //                                   style: TextStyle(
                  //                                     color: Theme.of(context)
                  //                                         .colorScheme
                  //                                         .onSecondaryContainer,
                  //                                   ),
                  //                                 )
                  //                               ],
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     const SizedBox(
                  //                       height: 50,
                  //                     ),
                  //                     AutoSizeText.rich(
                  //                       TextSpan(
                  //                         text: state.quizItems[index].question,
                  //                       ),
                  //                       textAlign: TextAlign.center,
                  //                       style: TextStyle(
                  //                           fontSize: 20,
                  //                           fontWeight: FontWeight.bold,
                  //                           color: Theme.of(context)
                  //                               .colorScheme
                  //                               .onPrimary),
                  //                       maxLines: 3,
                  //                       overflow: TextOverflow.ellipsis,
                  //                     ),
                  //                     ListView.separated(
                  //                       itemBuilder: (context, questionIndex) {
                  //                         return CustomInkWell(
                  //                           borderRadius:
                  //                               BorderRadius.circular(50),
                  //                           backgroundColor: state
                  //                                       .quizItems[index]
                  //                                       .answered ==
                  //                                   questionIndex
                  //                               ? questionAnsweredCorrectly ==
                  //                                       true
                  //                                   ? const Color.fromRGBO(
                  //                                       105, 251, 203, 1)
                  //                                   : const Color.fromRGBO(
                  //                                       255, 105, 105, 1)
                  //                               : Colors.transparent,
                  //                           onTap: () {
                  //                             _submit(
                  //                                 questionIndex, index, state);
                  //                           },
                  //                           child: Container(
                  //                             padding:
                  //                                 const EdgeInsets.symmetric(
                  //                                     horizontal:
                  //                                         Constants.space21),
                  //                             decoration: BoxDecoration(
                  //                               color: Colors.transparent,
                  //                               borderRadius:
                  //                                   BorderRadius.circular(50),
                  //                               border: Border.all(
                  //                                   color: Colors.black),
                  //                             ),
                  //                             height: 50,
                  //                             child: Center(
                  //                                 child: AutoSizeText(
                  //                               state.quizItems[index]
                  //                                   .options[questionIndex],
                  //                               style: const TextStyle(
                  //                                 fontSize: 14,
                  //                                 fontWeight: FontWeight.bold,
                  //                                 color: Colors.black,
                  //                               ),
                  //                               maxLines: 2,
                  //                               overflow: TextOverflow.ellipsis,
                  //                             )),
                  //                           ),
                  //                         );
                  //                       },
                  //                       itemCount: 4,
                  //                       shrinkWrap: true,
                  //                       separatorBuilder:
                  //                           (BuildContext context, int index) {
                  //                         return const SizedBox(
                  //                           height: Constants.space21,
                  //                         );
                  //                       },
                  //                     )
                  //                   ],
                  //                 ),
                  //     );
                  //   },
                  // ),
                  const SizedBox(height: Constants.space41),
                  if (state.answerLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                  if (!quizEnded)
                    if (!state.answerLoading)
                      Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.space16),
                          child: BigButton(
                              svgIconPath: 'assets/icons/eye-icon.svg',
                              text: 'Dar un vistazo a la lectura',
                              onPressed: widget.onPressedSeeStory),
                        ),
                        const SizedBox(height: Constants.space18),
                        LinkButton(
                          text: "No, gracias, no quiero participar",
                          onTap: () {
                            Navigator.of(context).pop(false);
                          },
                        ),
                      ]),
                  if (quizEnded)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.space16),
                      child: BigButton(
                          text: 'Terminar',
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                    ),
                ],
              );
      },
    );
  }

  _voteLikeOrDislike(
      int quizItemId, bool liked, int questionIndex, QuizState state) {
    final quizItem = state.quizItems[questionIndex];
    final cubit = context.read<QuizCubit>();
    quizItem.liked = liked;
    _updateQuizAnswers(state);
    cubit.voteLikeOrDislike(quizItemId, liked);
  }

  _next() {
    _swiperController.swipeLeft();
  }

  _submit(int answerIndex, int questionIndex, QuizState state) {
    final quizItem = state.quizItems[questionIndex];

    quizItem.answered = answerIndex;
    quizItem.wasCorrect =
        quizItem.options[answerIndex] == quizItem.correctAnswer;
    _updateQuizAnswers(state);

    if (_verifyIfAllQuizQuestionsAreFinished(state)) {
      _finishQuiz(state);
    }
  }

  bool _verifyIfAllQuizQuestionsAreFinished(QuizState state) {
    bool allQuestionsAnswered = true;
    for (var element in state.quizItems) {
      if (element.answered == null) {
        allQuestionsAnswered = false;
      }
    }

    return allQuestionsAnswered;
  }

  _updateQuizAnswers(QuizState state) {
    context.read<QuizCubit>().updateQuizAnswers(state.quizItems);
    setState(() {});
  }

  _finishQuiz(QuizState state) async {
    final cubit = context.read<QuizCubit>();
    await Future.delayed(const Duration(milliseconds: 300));
    cubit.finishQuiz(state.quizItems).then((_) {
      // Navigator.of(context).pop(true);
      setState(() {
        quizEnded = true;
      });
    });
  }
}

class _SuccessAnswer extends StatelessWidget {
  const _SuccessAnswer({
    required this.points,
    this.onNext,
    required this.likeOrDislike,
    required this.onLoading,
    this.liked,
  });
  final int points;
  final Function()? onNext;
  final Function(bool) likeOrDislike;
  final bool? liked;
  final bool onLoading;

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
                Text(' + $points ',
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
            onLoading
                ? const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: onPrimaryContainerColor,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              likeOrDislike(true);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.thumb_up, color: Colors.green),
                                if (liked == true)
                                  const SizedBox(width: Constants.space8),
                                if (liked == true)
                                  const Text(
                                    '+1',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: Constants.space41),
                          GestureDetector(
                            onTap: () {
                              likeOrDislike(false);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.thumb_down, color: Colors.red),
                                if (liked == false && liked != null)
                                  const SizedBox(width: Constants.space8),
                                if (liked == false && liked != null)
                                  const Text(
                                    '+1',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                              ],
                            ),
                          ),
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

class _WrongAnswer extends StatelessWidget {
  const _WrongAnswer({
    required this.correctAnswer,
    required this.explanation,
    this.onNext,
    required this.likeOrDislike,
    required this.onLoading,
    this.liked,
  });
  final String correctAnswer;
  final String explanation;
  final Function()? onNext;
  final Function(bool) likeOrDislike;
  final bool onLoading;
  final bool? liked;

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
            onLoading
                ? const Center(
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: onPrimaryContainerColor,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              likeOrDislike(true);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.thumb_up, color: Colors.green),
                                if (liked == true)
                                  const SizedBox(width: Constants.space8),
                                if (liked == true)
                                  const Text(
                                    '+1',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: Constants.space41),
                          GestureDetector(
                            onTap: () {
                              likeOrDislike(false);
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.thumb_down, color: Colors.red),
                                if (liked == false)
                                  const SizedBox(width: Constants.space8),
                                if (liked == false)
                                  const Text(
                                    '+1',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                              ],
                            ),
                          ),
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

  final QuizState state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Constants.space21,
          vertical: Constants.space21 + MediaQuery.paddingOf(context).top),
      child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.space21, vertical: Constants.space21),
          width: MediaQuery.sizeOf(context).width,
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
                TextSpan(
                  text: state.bonusTotalPoints > 0
                      ? 'Felicidades'
                      : 'Buen Intento!',
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary
                        .withOpacity(0.7)),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              AutoSizeText.rich(
                TextSpan(
                  text: state.bonusTotalPoints > 0
                      ? '¡Terminaste el quiz!'
                      : '¡Sigue intentando!',
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
              if (state.bonusTotalPoints > 0 ||
                  (state.readPoints != null && state.readPoints!.base > 0))
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
                        if (state.readPoints != null &&
                            state.readPoints!.base > 0)
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
                        if (state.bonusTotalPoints > 0)
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
          )),
    );
  }
}
