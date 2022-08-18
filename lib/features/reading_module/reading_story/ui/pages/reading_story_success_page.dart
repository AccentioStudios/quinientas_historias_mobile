import 'package:flutter/material.dart';

import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/widgets/big_button.dart';

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
              ...recomendedStories!.map((story) => Text(story.title)).toList(),
            BigButton(
                text: 'Volver al home',
                svgIconPath: 'assets/icons/home-outline-icon.svg',
                onPressed: () {
                  Navigator.of(context, rootNavigator: true)
                      .pushNamed(Routes.homeNavigator);
                })
          ],
        ),
      ),
    );
  }
}
