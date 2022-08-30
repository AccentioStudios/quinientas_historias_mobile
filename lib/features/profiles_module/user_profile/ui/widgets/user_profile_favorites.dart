import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/story_cover.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../reading_module/reading_story/reading_story_provider.dart';
import '../bloc/cubit/user_profile_cubit.dart';

class UserFavorites extends StatelessWidget {
  const UserFavorites({Key? key, this.state}) : super(key: key);
  final UserProfileState? state;

  @override
  Widget build(BuildContext context) {
    return PaddingColumn(
        padding: const EdgeInsets.all(Constants.space16),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            child: Text(
              'Favoritos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: Constants.space21),
          GridView.count(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisSpacing: Constants.space12,
            mainAxisSpacing: Constants.space12,
            childAspectRatio: 109 / 147,
            crossAxisCount: 3,
            children: <Widget>[
              ...state!.user!.favoriteStories!.map((story) => StoryCover(
                    story: story,
                    onTap: () => _navigateToStoryPage(context, story),
                  ))
            ],
          ),
        ]);
  }

  void _navigateToStoryPage(
    BuildContext context,
    Story story,
  ) {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (_) => ReadingStoryProvider(
              storyId: story.id,
            )));
  }
}
