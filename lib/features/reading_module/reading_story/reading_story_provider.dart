import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/routes/auto_router.dart';
import '../../home/ui/bloc/cubit/home_cubit.dart';
import 'data/repositories/reading_story_repository.dart';
import 'data/useCases/reading_story_usecases.dart';
import 'ui/bloc/cubit/reading_story_cubit.dart';
import 'ui/pages/reading_story_page.dart';

@RoutePage<bool?>()
class ReadingStoryProvider extends StatelessWidget {
  const ReadingStoryProvider(
      {super.key, @PathParam('id') required this.storyId, this.homeCubit});
  final HomeCubit? homeCubit;
  final int storyId;
  @override
  Widget build(BuildContext context) {
    final useCases = ReadingStoryUseCases(repository: ReadingStoryRepository());

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) {
          return ReadingStoryCubit(readingStoryUseCases: useCases);
        }),
        if (homeCubit != null)
          BlocProvider.value(
            value: homeCubit!,
          ),
      ],
      child: ReadingStoryPage(
        storyId: storyId,
      ),
    );
  }

  static Future<bool?> openStory(BuildContext context, {required int storyId}) {
    if (storyId != 0) {
      return AutoRouter.of(context).push<bool?>(
        ReadingStoryRoute(
          storyId: storyId,
        ),
      );
    }
    return Future.value(false);
  }
}
