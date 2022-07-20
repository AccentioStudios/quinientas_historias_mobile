import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/data/entities/story_progress_entity.dart';
import '../../../../../core/mixins/stream_disposable.dart';
import '../../data/useCases/reading_story_usecases.dart';

part 'reading_story_cubit.freezed.dart';
part 'reading_story_state.dart';

class ReadingStoryCubit extends Cubit<ReadingStoryState> with StreamDisposable {
  ReadingStoryCubit({required this.readingStoryUseCases})
      : super(const ReadingStoryState());
  final ReadingStoryUseCases readingStoryUseCases;
  load(int storyId, {Function? onSuccess, Function? onError}) {
    emit(state.copyWith(loading: true));
    readingStoryUseCases.loadStory(storyId).listen((storyProgress) {
      emit(state.copyWith(storyProgress: storyProgress));
    }, onError: (error) {
      if (onError != null) onError(error);
    }, onDone: () {
      emit(state.copyWith(loading: false));
    }).subscribe(this);
  }
}
