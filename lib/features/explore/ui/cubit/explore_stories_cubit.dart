import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/leaderboard_entity.dart';
import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/data/models/list_page.dart';
import '../../../../core/utils/colors.dart';
import '../../data/useCases/explore_stories_use_cases.dart';

part 'explore_stories_state.dart';
part 'explore_stories_cubit.freezed.dart';

class ExploreStoriesCubit extends Cubit<ExploreStoriesState> {
  ExploreStoriesCubit({required this.useCases})
      : super(const ExploreStoriesState());

  final ExploreStoriesUseCases useCases;

  Future<ListPage<Story>> getStories(int pageKey) async {
    final completer = Completer<ListPage<Story>>();
    // emit(state.copyWith(isLoading: true));
    useCases.getStories(pageKey: pageKey).listen((stories) {
      for (var story in stories.itemList) {
        story.coverColor = generateRandomColors().toHex();
      }
      // emit(state.copyWith(listPage: stories, isLoading: false));
      completer.complete(stories);
    }, onError: (error) {
      // emit(state.copyWith(isLoading: false));
      completer.completeError(error);
    });

    return completer.future;
  }

  applyFilters({
    int? id,
    String? title,
    int? tournamentId,
    String? orderBy,
  }) {
    emit(state.copyWith(
        filters: state.filters.copyWith(
      id: id,
      title: title,
      tournamentId: tournamentId,
      orderBy: orderBy,
    )));
  }
}
