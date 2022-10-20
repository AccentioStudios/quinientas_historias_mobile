import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/core/mixins/error_handling.dart';

import '../../../../../core/ui/components/story_summary.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/reading_story_cubit.dart';
import '../pages/reading_story_page.dart';

class ReadingStoryHeader extends StatelessWidget with ErrorHandling {
  const ReadingStoryHeader({Key? key, required this.state}) : super(key: key);

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
          SizedBox(height: MediaQuery.of(context).padding.top),
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
        Padding(
          padding: const EdgeInsets.only(right: Constants.space12),
          child: TextButton.icon(
            onPressed: () {
              saveFavorite(context);
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
      ],
    );
  }

  void saveFavorite(BuildContext context) {
    context
        .read<ReadingStoryCubit>()
        .saveFavorite(onError: (error) => handleError(context, error));
  }
}
