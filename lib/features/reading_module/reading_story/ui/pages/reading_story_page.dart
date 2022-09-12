import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/mixins/bottom_sheet_messages.dart';
import 'package:quinientas_historias/core/theme/theme.dart';
import 'package:quinientas_historias/core/ui/widgets/big_button.dart';
import 'package:quinientas_historias/features/reading_module/reading_story/data/models/reading_options_model.dart';
import 'package:quinientas_historias/features/reading_module/reading_story/ui/pages/reading_story_options_sheet_view.dart';
import 'package:quinientas_historias/features/reading_module/reading_story/ui/pages/reading_story_success_page.dart';
import 'package:quinientas_historias/features/reading_module/reading_story/ui/widgets/reading_story_appbar.dart';

import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/ui/widgets/custom_icon_button.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/reading_story_cubit.dart';

class ReadingStoryPage extends StatefulWidget
    with ErrorHandling, SheetMessages {
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

  // static double fontSizeBase = 1.20;
  // FontSize fontSize = FontSize.rem(fontSizeBase);
  // TextAlign pTextAlign = TextAlign.justify;
  // FontSize h1fontSize = FontSize.rem(fontSizeBase + 0.4);
  // FontSize h2fontSize = FontSize.rem(fontSizeBase + 0.2);
  // LineHeight lineHeight = LineHeight.percent(145);

  @override
  Widget build(BuildContext context) {
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
            body: !state.loading
                ? CustomScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      ReadingStoryAppbar(state: state),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.space21),
                        sliver: SliverToBoxAdapter(
                          child: Html(
                            style: {
                              "*": Style(
                                padding: EdgeInsets.zero,
                                margin: EdgeInsets.zero,
                                letterSpacing: 0.4,
                                fontFamily: 'Literata',
                                fontSize: state.readingOptions.fontSize,
                                lineHeight: state.readingOptions.lineHeight,
                              ),
                              "p": Style(
                                textAlign: state.readingOptions.pTextAlign,
                                margin: const EdgeInsets.only(bottom: 21),
                              ),
                              "h1": Style(
                                fontSize: state.readingOptions.h1fontSize,
                                textAlign: TextAlign.center,
                                margin: const EdgeInsets.only(bottom: 21),
                              ),
                              "h2": Style(
                                fontSize: state.readingOptions.h2fontSize,
                                textAlign: TextAlign.left,
                                margin: const EdgeInsets.only(bottom: 21),
                              ),
                              "ul": Style(
                                margin: const EdgeInsets.only(bottom: 21),
                              ),
                              "br": Style(
                                margin: const EdgeInsets.only(bottom: 21),
                              ),
                            },
                            // data: state.story?.content,
                            data:
                                '''<h1>One morning, when Gregor Samsa woke from troubled
                               dreams.</h1>
                               <p>One morning, when Gregor Samsa woke from troubled
                               dreams, he found himself transformed in his bed into
                               a horrible vermin. He lay on his armour-like back,
                               and if he lifted his head a little he could see his
                               brown belly, slightly domed and divided by arches into
                               stiff sections. The bedding was hardly able to cover
                               <strong>strong</strong> it and seemed ready to slide
                               off any moment. His many legs, pitifully thin
                               compared with the size of the rest of him,
                               <a class="external ext" href="#">link</a> waved about
                               helplessly as he looked. "What's happened to me? " he
                               thought. It wasn't a dream. His room, a proper human
                               room although a little too small, lay peacefully
                               between its four familiar walls.</p>
                               <h1>One morning, when Gregor Samsa woke from troubled
                               dreams.</h1>
                               <h2>The bedding was hardly able to cover it.</h2>
                               <p>It showed a lady fitted out with a fur hat and fur
                               boa who sat upright, raising a heavy fur muff that
                               covered the whole of her lower arm towards the
                               viewer.</p>
                               <h2>The bedding was hardly able to cover it.</h2>
                               <p>It showed a lady fitted out with a fur hat and fur
                               boa who sat upright, raising a heavy fur muff that
                               covered the whole of her lower arm towards the
                               viewer.</p>
                               <ul>
                               <li>Lorem ipsum dolor sit amet consectetuer.</li>
                               <li>Aenean commodo ligula eget dolor.</li>
                               <li>Aenean massa cum sociis natoque penatibus.</li>
                               </ul>
                               <p>It showed a lady fitted out with a fur hat and fur
                               boa who sat upright, raising a heavy fur muff that
                               covered the whole of her lower arm towards the
                               viewer.</p>
                               <form action="#" method="post">
                               <fieldset>
                                 <label for="name">Name:</label>
                                 <input type="text" id="name" placeholder="Enter your
                               full name" />
          
                                 <label for="email">Email:</label>
                                 <input type="email" id="email" placeholder="Enter
                               your email address" />
          
                                 <label for="message">Message:</label>
                                 <textarea id="message" placeholder="What's on your
                               mind?"></textarea>
          
                                 <input type="submit" value="Send message" />
          
                               </fieldset>
                               </form>
                               elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>
                               <p>It showed a lady fitted out with a fur hat and fur
                               boa who sat upright, raising a heavy fur muff that
                               covered the whole of her lower arm towards the
                               viewer.</p>
                               <table class="data">
                               <tr>
                                 <th>Entry Header 1</th>
                                 <th>Entry Header 2</th>
                                 <th>Entry Header 3</th>
                                 <th>Entry Header 4</th>
                               </tr>
                               <tr>
                                 <td>Entry First Line 1</td>
                                 <td>Entry First Line 2</td>
                                 <td>Entry First Line 3</td>
                                 <td>Entry First Line 4</td>
                               </tr>
                               <tr>
                                 <td>Entry Line 1</td>
                                 <td>Entry Line 2</td>
                                 <td>Entry Line 3</td>
                                 <td>Entry Line 4</td>
                               </tr>
                               <tr>
                                 <td>Entry Last Line 1</td>
                                 <td>Entry Last Line 2</td>
                                 <td>Entry Last Line 3</td>
                                 <td>Entry Last Line 4</td>
                               </tr>
                               </table>
                               <p>It showed a lady fitted out with a fur hat and fur
                               boa who sat upright, raising a heavy fur muff that
                               covered the whole of her lower arm towards the
                               viewer.</p><h1>One morning, when Gregor Samsa woke from troubled
                               dreams.</h1>
                               <p>One morning, when Gregor Samsa woke from troubled
                               dreams, he found himself transformed in his bed into
                               a horrible vermin. He lay on his armour-like back,
                               and if he lifted his head a little he could see his
                               brown belly, slightly domed and divided by arches into
                               stiff sections. The bedding was hardly able to cover
                               <strong>strong</strong> it and seemed ready to slide
                               off any moment. His many legs, pitifully thin
                               compared with the size of the rest of him,
                               <a class="external ext" href="#">link</a> waved about
                               helplessly as he looked. "What's happened to me? " he
                               thought. It wasn't a dream. His room, a proper human
                               room although a little too small, lay peacefully
                               between its four familiar walls.</p>
                               <h1>One morning, when Gregor Samsa woke from troubled
                               dreams.</h1>
                               <h2>The bedding was hardly able to cover it.</h2>
                               <p>It showed a lady fitted out with a fur hat and fur
                               boa who sat upright, raising a heavy fur muff that
                               covered the whole of her lower arm towards the
                               viewer.</p>
                               <h2>The bedding was hardly able to cover it.</h2>
                               <p>It showed a lady fitted out with a fur hat and fur
                               boa who sat upright, raising a heavy fur muff that
                               covered the whole of her lower arm towards the
                               viewer.</p>
                               <ul>
                               <li>Lorem ipsum dolor sit amet consectetuer.</li>
                               <li>Aenean commodo ligula eget dolor.</li>
                               <li>Aenean massa cum sociis natoque penatibus.</li>
                               </ul>
                               <p>It showed a lady fitted out with a fur hat and fur
                               boa who sat upright, raising a heavy fur muff that
                               covered the whole of her lower arm towards the
                               viewer.</p>
                               <form action="#" method="post">
                               <fieldset>
                                 <label for="name">Name:</label>
                                 <input type="text" id="name" placeholder="Enter your
                               full name" />
          
                                 <label for="email">Email:</label>
                                 <input type="email" id="email" placeholder="Enter
                               your email address" />
          
                                 <label for="message">Message:</label>
                                 <textarea id="message" placeholder="What's on your
                               mind?"></textarea>
          
                                 <input type="submit" value="Send message" />
          
                               </fieldset>
                               </form>
                               elit eget tincidunt condimentum, eros ipsum rutrum orci, sagittis tempus lacus enim ac dui. Donec non enim in turpis pulvinar facilisis. Ut felis. Praesent dapibus, neque id cursus faucibus, tortor neque egestas augue, eu vulputate magna eros eu erat. Aliquam erat volutpat. Nam dui mi, tincidunt quis, accumsan porttitor, facilisis luctus, metus</p>
                               <p>It showed a lady fitted out with a fur hat and fur
                               boa who sat upright, raising a heavy fur muff that
                               covered the whole of her lower arm towards the
                               viewer.</p>
                               <table class="data">
                               <tr>
                                 <th>Entry Header 1</th>
                                 <th>Entry Header 2</th>
                                 <th>Entry Header 3</th>
                                 <th>Entry Header 4</th>
                               </tr>
                               <tr>
                                 <td>Entry First Line 1</td>
                                 <td>Entry First Line 2</td>
                                 <td>Entry First Line 3</td>
                                 <td>Entry First Line 4</td>
                               </tr>
                               <tr>
                                 <td>Entry Line 1</td>
                                 <td>Entry Line 2</td>
                                 <td>Entry Line 3</td>
                                 <td>Entry Line 4</td>
                               </tr>
                               <tr>
                                 <td>Entry Last Line 1</td>
                                 <td>Entry Last Line 2</td>
                                 <td>Entry Last Line 3</td>
                                 <td>Entry Last Line 4</td>
                               </tr>
                               </table>
                               <p>It showed a lady fitted out with a fur hat and fur
                               boa who sat upright, raising a heavy fur muff that
                               covered the whole of her lower arm towards the
                               viewer.</p>''',
                          ),
                        ),
                      ),
                      SliverPadding(
                        sliver: SliverToBoxAdapter(
                          child: BigButton(
                            onPressed: () {
                              completeReading();
                            },
                            text: 'Terminar Lectura',
                            svgIconPath:
                                'assets/icons/book-open-outline-icon.svg',
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.space41,
                            vertical: Constants.space21),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 75)),
                    ],
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
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

  void completeReading() {
    context.read<ReadingStoryCubit>().progressStreamController.close();
    context.read<ReadingStoryCubit>().completeStory(
        onSuccess: (response) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ReadingStorySuccessPage(
              points: response.points,
              recomendedStories: response.recomendedStories,
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
      onPressed: () {
        saveFavorite();
      },
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

  void saveFavorite() {
    BlocProvider.of<ReadingStoryCubit>(context)
        .saveFavorite(onError: (error) => widget.handleError(context, error));
  }
}
