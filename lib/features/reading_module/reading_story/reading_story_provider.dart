import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/features/reading_module/reading_story/bloc/cubit/reading_story_cubit.dart';
import 'package:quinientas_historias/features/reading_module/reading_story/data/repositories/reading_story_repository.dart';
import 'package:quinientas_historias/features/reading_module/reading_story/data/useCases/reading_story_usecases.dart';
import 'package:quinientas_historias/features/reading_module/reading_story/ui/pages/reading_story_page.dart';

import '../../home/bloc/cubit/home_cubit.dart';

class ReadingStoryProvider extends StatelessWidget {
  const ReadingStoryProvider(
      {Key? key, required this.storyId, required this.homeCubit})
      : super(key: key);
  final HomeCubit homeCubit;
  final int storyId;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ReadingStoryCubit(
              readingStoryUseCases:
                  ReadingStoryUseCases(repository: ReadingStoryRepository())),
        ),
        BlocProvider.value(
          value: homeCubit,
        ),
      ],
      child: ReadingStoryPage(
        storyId: storyId,
      ),
    );
  }
}
