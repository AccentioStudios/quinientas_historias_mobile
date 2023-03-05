import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quinientas_historias/core/utils/constants.dart';

import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/ui/widgets/story_cover.dart';
import '../../../../reading_module/reading_story/reading_story_provider.dart';

class UserFavoritesTabView extends StatelessWidget {
  const UserFavoritesTabView({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    if (user.favoriteStories != null) {
      return user.favoriteStories!.isNotEmpty
          ? Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.space18),
              child: GridView.count(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: Constants.space12,
                mainAxisSpacing: Constants.space12,
                childAspectRatio: 109 / 147,
                crossAxisCount: 3,
                children: [
                  ...user.favoriteStories!.map((favorite) => StoryCover(
                        story: favorite,
                        onTap: () {
                          _navigateToStoryPage(context, favorite);
                        },
                      )),
                ],
              ),
            )
          : const UserFavoritesEmptyState();
    }
    return const UserFavoritesEmptyState();
  }

  void _navigateToStoryPage(BuildContext context, Story story) {
    ReadingStoryProvider.openStory(context, storyId: story.id);
  }
}

class UserFavoritesEmptyState extends StatelessWidget {
  const UserFavoritesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset('assets/icons/bookmark-outline-icon.svg'),
            ),
            const SizedBox(height: Constants.space21),
            const Text('No hay favoritos todavía'),
            const SizedBox(height: Constants.space41),
          ]),
    );
  }
}
