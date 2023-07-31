import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/core/mixins/error_handling.dart';

import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/ui/components/story_summary.dart';
import '../../../../../core/ui/widgets/role_widget.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/functions.dart';
import '../bloc/cubit/reading_story_cubit.dart';
import '../pages/reading_story_page.dart';

class ReadingStoryHeader extends StatelessWidget with ErrorHandling {
  const ReadingStoryHeader({super.key, required this.state});

  final ReadingStoryState state;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
      centerTitle: true,
      toolbarHeight: 64,
      flexibleSpace: SingleChildScrollView(
        child: Column(children: [
          SizedBox(height: MediaQuery.paddingOf(context).top),
          const SizedBox(height: 64),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
            child: Text(state.story?.title ?? 'Modo Lectura',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onBackground)),
          ),
          const SizedBox(height: Constants.space21),
          SummaryStory(story: state.story),
          const SizedBox(height: Constants.space21),
        ]),
      ),
      actions: <Widget>[
        TextButton.icon(
            onPressed: () {
              _share(state.story);
            },
            icon: Icon(Icons.share,
                color: Theme.of(context).colorScheme.onBackground),
            label: Text(
              'Compartir',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold),
            )),
        RoleWidget(
          roles: const [
            Role.admin,
            Role.editor,
            Role.captain,
            Role.reader,
          ],
          child: Padding(
            padding: const EdgeInsets.only(right: Constants.space12),
            child: TextButton.icon(
              onPressed: () {
                saveFavorite(context, favorited: state.story?.favorited);
              },
              icon: FavoriteBtn(state: state),
              label: Text(
                state.story?.favorited == true
                    ? 'Quitar favorito'
                    : 'Agregar a favoritos',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _share(Story? story) async {
    if (story != null) {
      Uri link = await generateDynamicLinkForStory(story);
      debugPrint('Link to story: $link');
      shareLink(link.toString(), story.title);
    }
  }

  void saveFavorite(BuildContext context, {bool? favorited}) {
    if (favorited == true) {
      context
          .read<ReadingStoryCubit>()
          .removeFavorite(onError: (error) => handleError(context, error));
      return;
    }
    context
        .read<ReadingStoryCubit>()
        .saveFavorite(onError: (error) => handleError(context, error));
  }
}
