import 'package:flutter/material.dart';

import '../../../../../core/ui/components/story_summary.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/reading_story_cubit.dart';
import '../pages/reading_story_page.dart';

class ReadingStoryAppbar extends StatelessWidget {
  const ReadingStoryAppbar({Key? key, required this.state}) : super(key: key);

  final ReadingStoryState state;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      centerTitle: true,
      toolbarHeight: 64,
      title: Text(state.story?.title ?? 'Modo Lectura',
          style: const TextStyle(fontWeight: FontWeight.bold)),
      floating: false,
      pinned: true,
      snap: false,
      flexibleSpace: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          const SizedBox(height: 64),
          SummaryStory(story: state.story),
          const SizedBox(height: Constants.space21),
        ]),
      ),
      expandedHeight: MediaQuery.of(context).padding.top + 160,
      actions: <Widget>[
        FavoriteBtn(state: state),
      ],
    );
  }
}
