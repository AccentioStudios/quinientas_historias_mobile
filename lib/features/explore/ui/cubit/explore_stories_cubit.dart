import 'dart:async';

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

  Future<void> getStories() async {
    final completer = Completer<void>();
    emit(state.copyWith(isLoading: true));
    useCases.getStories().listen((stories) {
      emit(state.copyWith(exploreStories: stories, isLoading: false));
      completer.complete();
    }, onError: (error) {
      emit(state.copyWith(isLoading: false));
      completer.completeError(error);
    });

    return completer.future;
  }
}
