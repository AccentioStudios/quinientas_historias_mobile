import 'package:flutter/material.dart';

import '../../data/entities/story_entity.dart';
import '../../utils/constants.dart';
import '../widgets/author_name_chip.dart';
import '../widgets/story_summary_metadata.dart';

class SummaryStory extends StatelessWidget {
  const SummaryStory({Key? key, required this.story}) : super(key: key);
  final Story? story;

  @override
  Widget build(BuildContext context) {
    return story == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.space21),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AuthorNameChip(
                  author: story!.author,
                ),
                const SizedBox(height: Constants.space18),
                StorySummaryMetadata(
                  readNumber: 0,
                  readingTime: story?.readingTime,
                ),
              ],
            ),
          );
  }
}
