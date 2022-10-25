import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/ui/widgets/story_cover.dart';
import '../../../../core/utils/constants.dart';
import '../../../home/ui/bloc/cubit/home_cubit.dart';
import '../../../reading_module/reading_story/reading_story_provider.dart';
import '../cubit/explore_stories_cubit.dart';

class ExploreStoriesPage extends StatelessWidget {
  const ExploreStoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorar'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<ExploreStoriesCubit, ExploreStoriesState>(
        builder: (context, state) {
          return GridView.count(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisSpacing: Constants.space12,
            mainAxisSpacing: Constants.space12,
            childAspectRatio: 109 / 147,
            crossAxisCount: 3,
            children: [
              ...state.exploreStories.map((story) => StoryCover(
                    story: story,
                    onTap: () {
                      _navigateToStoryPage(context, story);
                    },
                  )),
            ],
          );
        },
      ),
    );
  }

  void _navigateToStoryPage(
    BuildContext context,
    Story story,
  ) {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (_) => ReadingStoryProvider(
              homeCubit: BlocProvider.of<HomeCubit>(context),
              storyId: story.id,
            )));
  }
}
