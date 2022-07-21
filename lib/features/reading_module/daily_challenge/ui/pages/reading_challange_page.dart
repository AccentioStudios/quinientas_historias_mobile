import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/data/entities/daily_challenge_entity.dart';
import '../../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/components/story_summary.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/ui/widgets/percentage_progress_bar.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../home/bloc/cubit/home_cubit.dart';
import '../../../reading_story/reading_story_provider.dart';
import '../../bloc/cubit/daily_challenge_cubit.dart';
import '../widgets/reading_carousel_story.dart';

class DailyChallengePage extends StatefulWidget
    with ErrorHandling, SheetMessages {
  const DailyChallengePage(
      {Key? key,
      this.dailyChallenge,
      this.softGenerateNewChallenge = false,
      this.forceGenerateNewChallenge = false})
      : super(key: key);

  final DailyChallenge? dailyChallenge;
  final bool softGenerateNewChallenge;
  final bool forceGenerateNewChallenge;

  @override
  State<DailyChallengePage> createState() => _DailyChallengePageState();
}

class _DailyChallengePageState extends State<DailyChallengePage> {
  @override
  void didChangeDependencies() {
    getData(
      softGenerateNewChallenge: widget.softGenerateNewChallenge,
      forceGenerateNewChallenge: widget.forceGenerateNewChallenge,
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

    const TextStyle headerTextStyle =
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.4);

    return BlocBuilder<DailyChallengeCubit, DailyChallengeState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            await getData(isFromPullRefresh: true);
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              toolbarHeight: 64,
              title: const Text('Mis Lecturas Diarias',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              actions: [
                IconButton(
                  iconSize: 24,
                  onPressed: () {
                    widget.showGenerateNewChallengeMessage(context, (generate) {
                      if (generate == true) {
                        getData(
                          forceGenerateNewChallenge: true,
                        );
                      }
                    });
                  },
                  icon: SvgPicture.asset(
                      'assets/icons/refresh-challenge-icon.svg'),
                )
              ],
            ),
            body: state.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : !BlocProvider.of<DailyChallengeCubit>(context)
                        .verifyIfHasChallenge()
                    ? _HaveNoChallengeTodayScreen(
                        onTap: () {
                          getData(
                            forceGenerateNewChallenge: true,
                          );
                        },
                      )
                    : Stack(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: <Widget>[
                                ReadingCarouselStory(
                                  stories: state.data.challenge,
                                  onPageChanged: (index, reason) {
                                    BlocProvider.of<DailyChallengeCubit>(
                                            context)
                                        .changeStoryHovered(index);
                                  },
                                ),
                                SizedBox(
                                  width: 145,
                                  child: Column(children: <Widget>[
                                    PercentageProgressBar(
                                      completedPercentage: calculatePercentage(
                                          state.data.count, state.data.readed),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      '${state.data.readed} de ${state.data.count} leidos',
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant,
                                      ),
                                    ),
                                  ]),
                                ),
                                const SizedBox(height: Constants.space21),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Constants.space21),
                                  child: Text(
                                    state.storyHovered!.title,
                                    style: headerTextStyle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: Constants.space12),
                                SummaryStory(story: state.storyHovered),
                                const SizedBox(height: Constants.space21),
                                _FirstLinesOfStory(
                                    text: state.storyHovered!.content),
                                const SizedBox(height: Constants.space21),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Constants.space41,
                                  vertical: Constants.space21),
                              child: BigButton(
                                svgIconPath:
                                    'assets/icons/book-open-outline-icon.svg',
                                elevation: 5,
                                onPressed: () {
                                  _navigateToReadingStory(
                                      state.storyHovered!.id, homeCubit);
                                },
                                text: 'Comenzar la lectura',
                              ),
                            ),
                          )
                        ],
                      ),
          ),
        );
      },
    );
  }

  Future<dynamic> getData({
    bool isFromPullRefresh = false,
    bool softGenerateNewChallenge = false,
    bool forceGenerateNewChallenge = false,
  }) {
    var completer = Completer();
    BlocProvider.of<DailyChallengeCubit>(context).getData(isFromPullRefresh,
        softGenerateNewChallenge: softGenerateNewChallenge,
        forceGenerateNewChallenge: forceGenerateNewChallenge,
        dailyChallengeOnMemory: widget.dailyChallenge,
        onSuccess: (dailyChallenge) {
      BlocProvider.of<HomeCubit>(context).saveDailyChallenge(dailyChallenge);
      completer.complete();
    }, onError: (error) {
      widget.handleError(context, error, onTap: () {
        Navigator.pushReplacementNamed(context, Routes.home);
      });
      completer.completeError(error);
    });

    return completer.future;
  }

  void _navigateToReadingStory(int storyId, HomeCubit cubit) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            ReadingStoryProvider(storyId: storyId, homeCubit: cubit),
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
}

class _FirstLinesOfStory extends StatelessWidget {
  const _FirstLinesOfStory({Key? key, required this.text}) : super(key: key);
  final String? text;
  @override
  Widget build(BuildContext context) {
    return text == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.space21),
            child: SizedBox(
              height: 340,
              child: Stack(
                children: [
                  Html(
                    style: {
                      "*": Style(
                        textAlign: TextAlign.justify,
                        padding: EdgeInsets.zero,
                        margin: EdgeInsets.zero,
                        fontFamily: 'Literata',
                        fontSize: FontSize.rem(1.20),
                        lineHeight: LineHeight.percent(143),
                      )
                    },
                    data: text,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      stops: [
                        0.2,
                        1,
                      ],
                      colors: [
                        Color(0xff101c29),
                        Color.fromARGB(22, 16, 28, 41)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    )),
                  ),
                ],
              ),
            ),
          );
  }
}

class _HaveNoChallengeTodayScreen extends StatelessWidget {
  const _HaveNoChallengeTodayScreen({Key? key, required this.onTap})
      : super(key: key);

  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              width: 50,
              child: SvgPicture.asset('assets/icons/challenge-xl-icon.svg'),
            ),
            const SizedBox(height: Constants.space21),
            const Text(
              'No hay reto de lecturas por ahora',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: Constants.space21),
            const Text(
              'Puedes generar un nuevo reto para ti ahora si quieres.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: Constants.space21),
            SizedBox(
              width: 170,
              child: BigButton(
                onPressed: () {
                  onTap();
                },
                text: 'Generar',
              ),
            ),
            const SizedBox(height: 80),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
