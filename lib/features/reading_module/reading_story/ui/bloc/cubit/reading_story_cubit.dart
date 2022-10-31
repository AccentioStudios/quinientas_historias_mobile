import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/story_ratings_entity.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';
import 'package:quinientas_historias/core/data/models/rate_story_request.dart';
import 'package:quinientas_historias/core/helpers/secure_storage_helper.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../core/data/entities/story_entity.dart';
import '../../../../../../core/data/models/save_favorite_request.dart';
import '../../../../../../core/mixins/stream_disposable.dart';
import '../../../data/models/reading_options_model.dart';
import '../../../data/models/set_story_progress_request.dart';
import '../../../data/models/set_story_progress_response.dart';
import '../../../data/useCases/reading_story_usecases.dart';

part 'reading_story_cubit.freezed.dart';
part 'reading_story_state.dart';

class ReadingStoryCubit extends Cubit<ReadingStoryState> with StreamDisposable {
  ReadingStoryCubit({
    required this.readingStoryUseCases,
  }) : super(ReadingStoryState(
          readingOptions: readingStoryUseCases.loadReadingOptions(),
        )) {
    progressStreamController.stream
        .debounceTime(const Duration(seconds: 1))
        .listen((progress) {
      updateProgressOfStory(progress);
    }).subscribe(this);
  }
  final ReadingStoryUseCases readingStoryUseCases;
  StreamController<int> progressStreamController = StreamController<int>();

  reloadReadingOptions() {
    emit(state.copyWith(
        readingOptions: readingStoryUseCases.loadReadingOptions()));
  }

  load(int storyId, {Function? onSuccess, Function? onError}) {
    emit(state.copyWith(loading: true));
    readingStoryUseCases.loadStory(storyId).listen((storyProgress) {
      emit(state.copyWith(
        story: storyProgress.story,
        storyProgress: storyProgress.progress,
        myRating: storyProgress.myRating,
      ));
      if (onSuccess != null) onSuccess();
    }, onError: (error) {
      if (onError != null) onError(error);
    }, onDone: () {
      emit(state.copyWith(loading: false));
    }).subscribe(this);
  }

  completeStory(
      {Function(SetStoryProgressResponse)? onSuccess,
      Function? onError}) async {
    emit(state.copyWith(loading: true));
    SetStoryProgressRequest request =
        SetStoryProgressRequest(progress: 0, storyId: state.story!.id);

    await Future.delayed(const Duration(seconds: 1));

    readingStoryUseCases.completeStory(request).listen((success) {
      if (onSuccess != null) onSuccess(success);
    }, onError: (error) {
      if (onError != null) onError(error);
      emit(state.copyWith(loading: false));
    }).subscribe(this);
  }

  updateProgressOfStory(progress,
      {Function? onSuccess, Function(SetStoryProgressResponse)? onError}) {
    if (state.story != null) {
      SetStoryProgressRequest request =
          SetStoryProgressRequest(progress: progress, storyId: state.story!.id);

      readingStoryUseCases.setStoryProgress(request).listen((success) {
        emit(state.copyWith(storyProgress: progress));
        if (onSuccess != null) onSuccess(success);
      }, onError: (error) {
        if (onError != null) onError(error);
      }).subscribe(this);
    }
  }

  saveFavorite({Function? onSuccess, Function? onError}) async {
    if (state.story != null) {
      SaveFavoriteRequest request =
          SaveFavoriteRequest(storyId: state.story!.id);
      emit(state.copyWith(saveFavoriteloading: true));

      // await Future.delayed(const Duration(seconds: 2));
      // emit(state.copyWith(saveFavoriteloading: false));

      readingStoryUseCases.saveFavorite(request).listen((response) {
        if (onSuccess != null) onSuccess();

        emit(state.copyWith(
            story: state.story?.copyWith(favorited: response.favorited)));
      }, onError: (error) {
        if (onError != null) onError(error);
        emit(state.copyWith(story: state.story?.copyWith(favorited: false)));
      }, onDone: () {
        emit(state.copyWith(saveFavoriteloading: false));
      }).subscribe(this);
    }
  }

  rateStory(RateStoryRequest request,
      {required Function onSuccess, required Function onError}) async {
    final session = await SecureStorageHelper.getSessionData();
    if (session?.user.type != UserType.prof &&
        session?.user.type != UserType.admin) {
      if (state.story != null) {
        readingStoryUseCases.rateStory(request).listen((response) {
          onSuccess();
        }, onError: (error) {
          onError(error);
        }, onDone: () {}).subscribe(this);
      }
    }
  }

  switchDarkMode({required bool isDarkMode}) {
    emit(state.copyWith(
        readingOptions: state.readingOptions
            .copyWith(theme: isDarkMode ? ThemeMode.dark : ThemeMode.light)));
    readingStoryUseCases.saveReadingOptions(state.readingOptions);
  }

  changeTextSize({required double fontSizeBase}) {
    emit(state.copyWith(
        readingOptions:
            state.readingOptions.copyWith(fontSizeBase: fontSizeBase)));
    readingStoryUseCases.saveReadingOptions(state.readingOptions);
  }
}
