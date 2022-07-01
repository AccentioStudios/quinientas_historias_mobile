import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../data/entities/story_entity.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';

class StoryCover extends StatelessWidget {
  const StoryCover({Key? key, required this.story, this.onTap})
      : super(key: key);

  final Story story;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      color: Theme.of(context).colorScheme.onPrimary,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );

    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Material(
        borderRadius: Constants.borderRadius18,
        clipBehavior: Clip.antiAlias,
        elevation: 5,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: story.coverColor != null
                  ? HexColor.fromHex(story.coverColor!)
                  : generateRandomColors(),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.space16),
              child: Column(
                children: [
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: AutoSizeText(
                        story.title,
                        maxLines: 4,
                        minFontSize: 13,
                        style: textStyle,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        wrapWords: false,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
