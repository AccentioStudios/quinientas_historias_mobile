import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/features/reading_module/reading_story/ui/bloc/cubit/reading_story_cubit.dart';

import '../../../../../core/data/entities/story_entity.dart';

class ReadingStorySuccessPage extends StatelessWidget {
  const ReadingStorySuccessPage({
    Key? key,
    required this.points,
    required this.recomendedStories,
  }) : super(key: key);

  final int? points;
  final List<Story>? recomendedStories;
  @override
  Widget build(BuildContext context) {
    // var state = context.read<ReadingStoryCubit>().state;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Success Page: Points $points',
            ),
            if (recomendedStories != null)
              ...recomendedStories!.map((story) => Text(story.title)).toList()
          ],
        ),
      ),
    );
  }
}
