import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/data/entities/story_progress_entity.dart';
import '../../../../../core/utils/constants.dart';

class ReadingCarouselStory extends StatelessWidget {
  const ReadingCarouselStory(
      {Key? key, this.stories, this.onPageChanged, this.onTap})
      : super(key: key);

  final List<StoryProgress>? stories;
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;
  final Function(int)? onTap;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    final TextStyle secondaryTextStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: 14,
    );

    double heightCarousel = 196 + 18 + 8;

    return SizedBox(
      height: heightCarousel,
      width: MediaQuery.of(context).size.width,
      child: !verifyIfHaveStories(stories)
          ? const SizedBox.shrink()
          : CarouselSlider(
              options: CarouselOptions(
                scrollPhysics: const BouncingScrollPhysics(),
                initialPage: searchCurrentReadingBook(),
                enableInfiniteScroll: false,
                aspectRatio: 145 / 196,
                viewportFraction: 0.43,
                height: heightCarousel,
                enlargeCenterPage: true,
                onPageChanged: onPageChanged,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: buildList(context, textStyle, secondaryTextStyle),
            ),
    );
  }

  bool verifyIfHaveStories(List<StoryProgress>? stories) {
    if (stories != null) {
      if (stories.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  int searchCurrentReadingBook() {
    try {
      return stories!.indexOf(stories!
          .firstWhere((element) => element.status == StoryStatus.reading));
    } catch (error) {
      return 0;
    }
  }

  void navigateToStory(int storyId) {
    if (onTap != null) {
      onTap!(storyId);
    }
  }

  List<Widget> buildList(BuildContext context, TextStyle headerTextStyle,
      TextStyle secondaryTextStyle) {
    Widget foregroundMutedLayer = Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black45,
    );

    return stories!
        .map((item) => Padding(
              padding: const EdgeInsets.only(
                  bottom: Constants.space18, top: Constants.space8),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Material(
                    elevation: 5,
                    borderRadius: Constants.borderRadius23,
                    child: GestureDetector(
                      onTap: () => navigateToStory(item.story.id),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        width: 145,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: Constants.borderRadius23,
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Constants.space16),
                              child: Column(
                                children: [
                                  Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 30),
                                        child: AutoSizeText(
                                          item.story.title,
                                          maxLines: 4,
                                          minFontSize: 13,
                                          style: headerTextStyle,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )),
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 18),
                                        child: Text(
                                          'Tiempo lectura \n${item.status}',
                                          style: secondaryTextStyle,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            item.status == StoryStatus.done
                                ? foregroundMutedLayer
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -6,
                    top: -6,
                    child: _ReadingBadge(
                      readingState: item.status,
                    ),
                  ),
                ],
              ),
            ))
        .toList();
  }
}

class _ReadingBadge extends StatelessWidget {
  const _ReadingBadge({
    Key? key,
    this.readingState = StoryStatus.unread,
  }) : super(key: key);

  final StoryStatus readingState;
  @override
  Widget build(BuildContext context) {
    return buildBadge(context);
  }

  Widget buildBadge(BuildContext context) {
    String svgIconPath = '';
    Color? badgeColor;
    double badgeWidth = 30;
    switch (readingState) {
      case StoryStatus.done:
        svgIconPath = 'assets/icons/done-badge.svg';
        badgeColor = Theme.of(context).colorScheme.onTertiaryContainer;
        badgeWidth = 30;
        break;
      case StoryStatus.reading:
        svgIconPath = 'assets/icons/reading-badge.svg';
        badgeColor = Theme.of(context).colorScheme.onSurface;
        badgeWidth = 95;
        break;
      case StoryStatus.unread:
        svgIconPath = '';
        badgeWidth = 0;
        break;
    }
    return Container(
      width: badgeWidth,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: Constants.borderRadius23,
        color: Theme.of(context).colorScheme.background,
      ),
      child: SvgPicture.asset(
        svgIconPath,
        color: badgeColor,
      ),
    );
  }
}
