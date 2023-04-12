import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/utils/constants.dart';

import '../../../../../core/data/entities/story_entity.dart';

import '../../../../../core/ui/widgets/story_cover.dart';
import '../../../../reading_module/reading_story/reading_story_provider.dart';
import '../../../data/entities/dashboard_entity.dart';
import '../../bloc/cubit/home_cubit.dart';
import '../../widgets/hero_header_widget.dart';
import '../../widgets/my_summary_carousel.dart';

class HomeReaderPage extends StatelessWidget {
  const HomeReaderPage({super.key, required this.state});

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics()
                .applyTo(const BouncingScrollPhysics()),
            slivers: [
              HomeReaderHeader(user: state.dashboard?.user),
              MySummaryCarousel(state: state),
              if (state.dashboard?.recomendedStories != null)
                ...state.dashboard!.recomendedStories.map(
                  (RecomendedStoriesDasboardDto e) {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Constants.space18),
                            child: Headline(
                              label: e.recomendationTitle,
                              secondaryLabel: e.recomendationDescription,
                            ),
                          ),
                          if (e.data.isNotEmpty)
                            SizedBox(
                              height: 165,
                              child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      const SizedBox(width: Constants.space18),
                                      ...e.data.map((Story story) => Padding(
                                            padding: const EdgeInsets.only(
                                                right: Constants.space12),
                                            child: StoryCover(
                                              story: story,
                                              onTap: () {
                                                _navigateToStoryPage(
                                                    context, story);
                                              },
                                            ),
                                          )),
                                      const SizedBox(width: Constants.space18),
                                    ],
                                  )),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              const SliverToBoxAdapter(
                  child: SizedBox(height: Constants.space41)),
            ]);
      },
    );
  }

  void _navigateToStoryPage(BuildContext context, Story story) {
    ReadingStoryProvider.openStory(context, storyId: story.id);
  }
}
