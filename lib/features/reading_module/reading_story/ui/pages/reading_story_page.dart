import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';

import '../../../../../core/data/models/jwt_token_model.dart';
import '../../../../../core/helpers/secure_storage_helper.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/theme/theme.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/ui/widgets/custom_icon_button.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/reading_story_cubit.dart';
import '../widgets/reading_story_appbar.dart';
import 'rate_story_sheet_view.dart';
import 'reading_story_options_sheet_view.dart';
import 'reading_story_success_page.dart';

class ReadingStoryPage extends StatefulWidget with ErrorHandling {
  const ReadingStoryPage({Key? key, required this.storyId}) : super(key: key);
  final int storyId;

  @override
  State<ReadingStoryPage> createState() => _ReadingStoryPageState();
}

class _ReadingStoryPageState extends State<ReadingStoryPage> {
  int progressValue = 0;

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    SystemChrome.setSystemUIChangeCallback((callback) => listenerUi(callback));
    scrollController.addListener(sendProgressOfStory);
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

  bool systemOverlaysAreVisible = false;
  @override
  Widget build(BuildContext context) {
    final unescape = HtmlUnescape();

    return BlocBuilder<ReadingStoryCubit, ReadingStoryState>(
      builder: (context, state) {
        return Theme(
          data: state.readingOptions.isDarkMode
              ? ThemeClass.darkTheme
              : ThemeClass.lightTheme,
          child: Scaffold(
            floatingActionButton: SizedBox(
              width: 93,
              child: FloatingActionButton(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: SizedBox(
                      width: 60,
                      height: 24,
                      child: SvgPicture.asset(
                        'assets/icons/reading-options-icon.svg',
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      )),
                  onPressed: () {
                    showReadingOptions(context);
                  }),
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
                              padding: EdgeInsets.zero,
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
                            saveFavorite(context);
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
                        child: BigButton(
                          onPressed: () async {
                            final user =
                                await SecureStorageHelper.getSessionData();
                            if (user?.role != Role.prof &&
                                user?.role != Role.admin) {
                              if (!mounted) return;
                              openRateStorySheet(context, state);
                              return;
                            }
                            if (!mounted) return;
                            completeReading(context.read<ReadingStoryCubit>());
                          },
                          text: 'Terminar Lectura',
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
          ),
        );
      },
    );
  }

  void saveFavorite(BuildContext context) {
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

  Future<void> listenerUi(bool change) async {
    setState(() {
      systemOverlaysAreVisible = change;
    });
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
    User? user = await SecureStorageHelper.getSessionData();
    cubit.progressStreamController.close();
    cubit.completeStory(
        onSuccess: (response) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ReadingStorySuccessPage(
              points: response.points,
              dailyChallenge: response.dailyChallenge,
              user: user,
            ),
          ));
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
  const FavoriteBtn({Key? key, required this.state}) : super(key: key);
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
