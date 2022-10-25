import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/story_entity.dart';
import '../../data/useCases/explore_stories_use_cases.dart';

part 'explore_stories_state.dart';
part 'explore_stories_cubit.freezed.dart';

class ExploreStoriesCubit extends Cubit<ExploreStoriesState> {
  ExploreStoriesCubit({required this.useCases})
      : super(const ExploreStoriesState());

  final ExploreStoriesUseCases useCases;
}
