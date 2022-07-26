import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/data/entities/story_progress_entity.dart';
import '../../../../../core/mixins/stream_disposable.dart';
import '../../data/models/set_progress_request.dart';
import '../../data/useCases/reading_story_usecases.dart';

part 'reading_story_cubit.freezed.dart';
part 'reading_story_state.dart';

class ReadingStoryCubit extends Cubit<ReadingStoryState> with StreamDisposable {
  ReadingStoryCubit({required this.readingStoryUseCases})
      : super(const ReadingStoryState()) {
    progressStreamController.stream
        .debounceTime(const Duration(seconds: 1))
        .listen((progress) {
      updateProgressOfStory(progress);
    }).subscribe(this);
  }
  final ReadingStoryUseCases readingStoryUseCases;
  StreamController<int> progressStreamController = StreamController<int>();

  load(int storyId, {Function? onSuccess, Function? onError}) {
    emit(state.copyWith(loading: true));
    readingStoryUseCases.loadStory(storyId).listen((storyProgress) {
      emit(state.copyWith(
          story: storyProgress.story, storyProgress: storyProgress.progress));
      if (onSuccess != null) onSuccess();
    }, onError: (error) {
      if (onError != null) onError(error);
    }, onDone: () {
      emit(state.copyWith(loading: false));
    }).subscribe(this);
  }

  updateProgressOfStory(progress, {Function? onSuccess, Function? onError}) {
    if (state.story != null) {
      SetStoryProgressRequest request =
          SetStoryProgressRequest(progress: progress, storyId: state.story!.id);

      readingStoryUseCases.setStoryProgress(request).listen((success) {
        emit(state.copyWith(storyProgress: progress));
        if (onSuccess != null) onSuccess();
      }, onError: (error) {
        if (onError != null) onError(error);
      }).subscribe(this);
    }
  }
}
