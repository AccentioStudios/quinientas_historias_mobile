import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/explore_stories_repository.dart';
import 'data/useCases/explore_stories_use_cases.dart';
import 'ui/cubit/explore_stories_cubit.dart';
import 'ui/pages/explore_stories_page.dart';

@RoutePage()
class ExploreStoriesProvider extends StatelessWidget {
  const ExploreStoriesProvider({super.key, @QueryParam('search') this.search});
  final String? search;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ExploreStoriesCubit(
          useCases:
              ExploreStoriesUseCases(repository: ExploreStoriesRepository())),
      child: const ExploreStoriesPage(),
    );
  }
}
