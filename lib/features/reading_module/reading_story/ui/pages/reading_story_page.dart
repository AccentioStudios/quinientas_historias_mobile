import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/mixins/error_handling.dart';

import '../../../../../core/ui/components/story_summary.dart';
import '../../../../../core/utils/constants.dart';
import '../../bloc/cubit/reading_story_cubit.dart';

class ReadingStoryPage extends StatefulWidget with ErrorHandling {
  const ReadingStoryPage({Key? key, required this.storyId}) : super(key: key);
  final int storyId;

  @override
  State<ReadingStoryPage> createState() => _ReadingStoryPageState();
}

class _ReadingStoryPageState extends State<ReadingStoryPage> {
  @override
  void initState() {
    SystemChrome.setSystemUIChangeCallback((callback) => listenerUi(callback));
    // changeUIToImmersive();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    loadStory();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timerOverlay.cancel();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //     overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

    super.dispose();
  }

  bool systemOverlaysAreVisible = false;
  late Timer timerOverlay;

  FontSize fontSize = FontSize.rem(1.20);
  LineHeight lineHeight = LineHeight.percent(143);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadingStoryCubit, ReadingStoryState>(
      builder: (context, state) {
        return Scaffold(
          body: !state.loading && state.storyProgress != null
              ? CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      backgroundColor: Theme.of(context).colorScheme.background,
                      centerTitle: true,
                      toolbarHeight: 64,
                      title: Text(
                          state.storyProgress?.story.title ?? 'Modo Lectura',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      floating: false,
                      pinned: true,
                      snap: false,
                      flexibleSpace: SingleChildScrollView(
                        child: Column(children: [
                          SizedBox(height: MediaQuery.of(context).padding.top),
                          const SizedBox(height: 64),
                          SummaryStory(story: state.storyProgress?.story),
                          const SizedBox(height: Constants.space21),
                        ]),
                      ),
                      expandedHeight: MediaQuery.of(context).padding.top + 160,
                      actions: [
                        IconButton(
                          iconSize: 24,
                          onPressed: () {},
                          icon: SvgPicture.asset(
                              'assets/icons/bookmark-outline-icon.svg'),
                        )
                      ],
                    ),
                    //                       const SizedBox(height: Constants.space21),
                    // Hero(
                    //     tag: 'summary_story',
                    //     child: SummaryStory(state: state)),
                    // const SizedBox(height: Constants.space21),

                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.space21),
                      sliver: SliverToBoxAdapter(
                        child: Html(
                          style: {
                            "*": Style(
                              textAlign: TextAlign.justify,
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                              fontFamily: 'Literata',
                              fontSize: fontSize,
                              lineHeight: lineHeight,
                            )
                          },
                          data: state.storyProgress!.story.content,
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  void changeUIToImmersive() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  Future<void> listenerUi(bool change) async {
    setState(() {
      systemOverlaysAreVisible = change;
    });
  }

  Future<void> loadStory() {
    var completer = Completer();

    BlocProvider.of<ReadingStoryCubit>(context).load(
      widget.storyId,
      onSuccess: () {
        completer.complete();
      },
      onError: (error) {
        widget.handleError<bool>(context, error,
            btnLabel: 'Intentar de nuevo',
            linkBtnLabel: 'Volver', linkBtnOnTap: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
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
