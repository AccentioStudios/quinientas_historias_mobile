import 'package:flutter/material.dart';
import 'package:quinientas_historias/core/ui/widgets/headline.dart';

import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/story_cover.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../reading_module/reading_story/reading_story_provider.dart';
import '../bloc/cubit/user_profile_cubit.dart';

class UserFavorites extends StatelessWidget {
  const UserFavorites({Key? key, required this.state}) : super(key: key);
  final UserProfileState state;

  @override
  Widget build(BuildContext context) {
    return PaddingColumn(
        padding: const EdgeInsets.only(
            left: Constants.space16,
            right: Constants.space16,
            bottom: Constants.space41),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Headline(label: 'Favoritos'),
          state.user!.userFavorites!.isNotEmpty
              ? GridView.count(
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: Constants.space12,
                  mainAxisSpacing: Constants.space12,
                  childAspectRatio: 109 / 147,
                  crossAxisCount: 3,
                  children: <Widget>[
                    if (state.user!.userFavorites != null)
                      ...state.user!.userFavorites!.map((story) => StoryCover(
                            story: Story(id: 1, title: 'manoestoesunaprueba'),
                            onTap: () => _navigateToStoryPage(context,
                                Story(id: 1, title: 'manoestoesunaprueba')),
                          ))
                  ],
                )
              : const Center(
                  child: Text('Todavía no tiene favoritos'),
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
