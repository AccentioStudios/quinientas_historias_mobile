import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/explore_stories_repository.dart';
import 'data/useCases/explore_stories_use_cases.dart';
import 'ui/cubit/explore_stories_cubit.dart';
import 'ui/pages/explore_stories_page.dart';

class ExploreStoriesProvider extends StatelessWidget {
  const ExploreStoriesProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ExploreStoriesCubit(
          useCases:
              ExploreStoriesUseCases(repository: ExploreStoriesRepository())),
      child: const ExploreStoriesPage(),
    );
  }

  static Future<bool?> open(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<bool>(
        MaterialPageRoute<bool>(
            builder: (_) => const ExploreStoriesProvider()));
  }
}
