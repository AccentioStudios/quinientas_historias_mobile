import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';
import 'package:quinientas_historias/features/challenges/sar_service.dart';

import '../../../../../core/data/dto/auth_dto.dart';
import '../../../../../core/integrations/secure_storage_service.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/ui/widgets/custom_icon_button.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../challenges/data/entities/challenge_sar_event.dart';
import '../bloc/cubit/reading_story_cubit.dart';
import '../widgets/reading_story_appbar.dart';
import 'rate_story_sheet_view.dart';
import 'reading_story_options_sheet_view.dart';
import 'reading_story_post_read_page.dart';

class ReadingStoryPage extends StatefulWidget with ErrorHandling {
  const ReadingStoryPage(
      {super.key, required this.storyId, required this.isQuickView});
  final int storyId;
  final bool isQuickView;

  @override
  State<ReadingStoryPage> createState() => _ReadingStoryPageState();
}

class _ReadingStoryPageState extends State<ReadingStoryPage> {
  int progressValue = 0;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    if (!widget.isQuickView) {
      scrollController.addListener(sendProgressOfStory);
      _sendTriggerStoryInit();
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    loadStory();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  _sendTriggerStoryInit() async {
    JwtPayload? userInfo =
        await GetIt.I<SecureStorageService>().getSessionData();
    if (userInfo != null) {
      // Trigger story init
      GetIt.I<SARService>()
          .emit(ChallengeSarTriggers.storyInit, userId: userInfo.id);
    }
  }

  bool systemOverlaysAreVisible = false;
  @override
  Widget build(BuildContext context) {
    final unescape = HtmlUnescape();

    return BlocBuilder<ReadingStoryCubit, ReadingStoryState>(
      builder: (context, state) {
        var bigButtonEndStory = BigButton(
          onPressed: () async {
            final user = await GetIt.I<SecureStorageService>().getSessionData();
            if (user?.role != Role.prof && user?.role != Role.admin) {
              if (!mounted) return;
              openRateStorySheet(context, state);
              return;
            }
            if (!mounted) return;
            completeReading(context.read<ReadingStoryCubit>());
          },
          text: 'Terminar Lectura',
        );
        var bigButtonBackFromQuickView = BigButton(
          onPressed: () async {
            if (!mounted) return;
            AutoRouter.of(context).pop(true);
          },
          text: 'Volver',
        );
        return Theme(
          data: state.readingOptions.isDarkMode
              ? ThemeClass.darkTheme
              : ThemeClass.lightTheme,
          child: Scaffold(
            floatingActionButton: SizedBox(
              width: MediaQuery.sizeOf(context).width - 34,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (widget.isQuickView)
                    Expanded(
                      child: FloatingActionButton(
                          backgroundColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Constants.space18),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(children: [
                                  const Icon(Icons.arrow_back),
                                  const SizedBox(width: 8),
                                  Text('Volver',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ]),
                                const Icon(Icons.remove_red_eye),
                              ],
                            ),
                          )),
                          onPressed: () {
                            AutoRouter.of(context).pop(true);
                          }),
                    ),
                  if (widget.isQuickView) const SizedBox(width: 10),
                  SizedBox(
                    width: 93,
                    child: FloatingActionButton(
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: SizedBox(
                            width: 60,
                            height: 24,
                            child: SvgPicture.asset(
                              'assets/icons/reading-options-icon.svg',
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            )),
                        onPressed: () {
                          showReadingOptions(context);
                        }),
                  ),
                ],
              ),
            ),
            body: state.loading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    controller: scrollController,
                    children: [
                      ReadingStoryHeader(state: state),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.space21),
                        child: Html(
                          style: {
                            "*": Style(
                              padding: HtmlPaddings.zero,
                              margin: Margins.zero,
                              letterSpacing: 0.4,
                              fontFamily: 'Literata',
                              fontSize: state.readingOptions.fontSize,
                              lineHeight: state.readingOptions.lineHeight,
                            ),
                            "p": Style(
                              textAlign: state.readingOptions.pTextAlign,
                              margin: Margins.only(bottom: 21),
                            ),
                            "h1": Style(
                              fontSize: state.readingOptions.h1fontSize,
                              textAlign: TextAlign.center,
                              margin: Margins.only(bottom: 21),
                            ),
                            "h2": Style(
                              fontSize: state.readingOptions.h2fontSize,
                              textAlign: TextAlign.left,
                              margin: Margins.only(bottom: 21),
                            ),
                            "ul": Style(
                              margin: Margins.only(bottom: 21),
                            ),
                            "br": Style(
                              margin: Margins.only(bottom: 21),
                            ),
                          },
                          data: unescape.convert(state.story?.content ?? ''),
                        ),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.space16),
                        child: InkWell(
                          borderRadius: Constants.borderRadius50,
                          onTap: () {
                            saveFavorite(context,
                                favorited: state.story?.favorited);
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FavoriteBtn(state: state),
                              Text(
                                  state.story?.favorited == true
                                      ? 'Quitar favorito'
                                      : 'Agregar a favoritos',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: Constants.space21),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.space16),
                        child: widget.isQuickView
                            ? bigButtonBackFromQuickView
                            : bigButtonEndStory,
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
          ),
        );
      },
    );
  }

  void saveFavorite(BuildContext context, {bool? favorited}) {
    if (favorited == true) {
      context.read<ReadingStoryCubit>().removeFavorite(
          onError: (error) => widget.handleError(context, error));
      return;
    }
    context
        .read<ReadingStoryCubit>()
        .saveFavorite(onError: (error) => widget.handleError(context, error));
  }

  void showReadingOptions(BuildContext context) {
    showModalBottomSheet<bool>(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(23.0), topRight: Radius.circular(23.0)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<ReadingStoryCubit>(),
        child: const ReadingStoryOptionsSheetView(),
      ),
    );
  }

  void openRateStorySheet(BuildContext context, ReadingStoryState state) {
    showModalBottomSheet<bool>(
      elevation: 0,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(23.0), topRight: Radius.circular(23.0)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<ReadingStoryCubit>(),
        child: RateStorySheetView(
          state: state,
        ),
      ),
    ).then((saved) {
      if (saved == true) {
        completeReading(context.read<ReadingStoryCubit>());
      }
    });
  }

  void changeUIToImmersive() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  void jumpToProgressOfStory() {
    final storyProgress =
        BlocProvider.of<ReadingStoryCubit>(context).state.storyProgress;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final double jumpToValue =
          (storyProgress * scrollController.position.maxScrollExtent) / 100;

      scrollController.jumpTo(jumpToValue);
    });
  }

  void sendProgressOfStory() {
    progressValue =
        ((scrollController.offset / scrollController.position.maxScrollExtent) *
                100)
            .toInt();
    if (progressValue >= 100) {
      progressValue = 99;
    }

    BlocProvider.of<ReadingStoryCubit>(context)
        .progressStreamController
        .add(progressValue);
  }

  void completeReading(ReadingStoryCubit cubit) async {
    JwtPayload? userInfo =
        await GetIt.I<SecureStorageService>().getSessionData();
    cubit.progressStreamController.close();
    cubit.completeStory(
        onSuccess: (response) async {
          if (userInfo != null) {
            // Trigger story_ended
            GetIt.I<SARService>()
                .emit(ChallengeSarTriggers.storyEnded, userId: userInfo.id);

            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: cubit,
                child: ReadingStoryPostReadPage(
                  points: response.points,
                  dailyChallenge: response.dailyChallenge,
                  user: userInfo.toUserEntity(),
                  // quizItems: response.quizItems,
                  quizItems: response.quizItems,
                  story: cubit.state.story!,
                  //[
                  // QuizItem(
                  //     id: 1,
                  //     question:
                  //         '1. Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet  Lorem ipsum dolor sit amet  Lorem ipsum dolor sit amet ',
                  //     options: [
                  //       'Lorem ipsum dolor sit amet 1',
                  //       'Lorem ipsum dolor sit amet 2',
                  //       'Lorem ipsum dolor sit amet 3',
                  //       'Lorem ipsum dolor sit amet 4'
                  //     ],
                  //     correctAnswer: 'Lorem ipsum dolor sit amet 1',
                  //     explanation:
                  //         'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In semper, dui non efficitur fermentum, neque orci efficitur ex, vel pretium tortor augue eu ligula. Nulla congue porttitor purus sit amet dictum. Suspendisse bibendum justo vitae dolor.',
                  //     points: 15),
                  // QuizItem(
                  //     id: 1,
                  //     question:
                  //         '2. Lorem ipsum dolor sit amet Lorem ipsum dolor sit amet  Lorem ipsum dolor sit amet  Lorem ipsum dolor sit amet ',
                  //     options: [
                  //       'Lorem ipsum dolor sit amet 1',
                  //       'Lorem ipsum dolor sit amet 2',
                  //       'Lorem ipsum dolor sit amet 3',
                  //       'Lorem ipsum dolor sit amet 4'
                  //     ],
                  //     correctAnswer: 'Lorem ipsum dolor sit amet 1',
                  //     explanation: 'Lorem ipsum dolor sit amet explain. 1',
                  //     points: 15),
                  //],
                ),
              ),
            ))
                .then((value) {
              Navigator.of(context).pop();
            });
          }
        },
        onError: (error) => widget.handleError(context, error));
  }

  void reloadReadingOptions() {
    BlocProvider.of<ReadingStoryCubit>(context).reloadReadingOptions();
  }

  Future<void> loadStory() {
    var completer = Completer();

    BlocProvider.of<ReadingStoryCubit>(context).load(
      widget.storyId,
      onSuccess: () {
        jumpToProgressOfStory();
        completer.complete();
      },
      onError: (error) {
        widget.handleError<bool>(context, error,
            btnLabel: 'Intentar de nuevo',
            linkBtnLabel: 'Volver', linkBtnOnTap: () {
          Navigator.of(context, rootNavigator: true).pop();
          Navigator.of(context, rootNavigator: true).pop();
        }).then((isRefresh) {
          if (isRefresh != null) {
            if (isRefresh) {
              loadStory();
            }
          }
        });
        completer.completeError(error);
      },
    );

    return completer.future;
  }
}

class FavoriteBtn extends StatefulWidget with ErrorHandling {
  const FavoriteBtn({super.key, required this.state});
  final ReadingStoryState state;

  @override
  State<FavoriteBtn> createState() => _FavoriteBtnState();
}

class _FavoriteBtnState extends State<FavoriteBtn> {
  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      loading: widget.state.saveFavoriteloading,
      icon: widget.state.story?.favorited ?? false
          ? SvgPicture.asset(
              'assets/icons/bookmark-icon.svg',
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            )
          : SvgPicture.asset(
              'assets/icons/bookmark-outline-icon.svg',
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
    );
  }
}
