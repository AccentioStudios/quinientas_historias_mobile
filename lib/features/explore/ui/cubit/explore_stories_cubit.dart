import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/data/models/list_page.dart';
import '../../../../core/utils/colors.dart';
import '../../data/dto/explore_stories_filtes.dto.dart';
import '../../data/useCases/explore_stories_use_cases.dart';

part 'explore_stories_cubit.freezed.dart';
part 'explore_stories_state.dart';

class ExploreStoriesCubit extends Cubit<ExploreStoriesState> {
  ExploreStoriesCubit({
    required this.useCases,
    this.tournamentId,
  }) : super(const ExploreStoriesState());

  final ExploreStoriesUseCases useCases;
  final int? tournamentId;

  Future<ListPage<Story>> getStories(int pageKey) async {
    final completer = Completer<ListPage<Story>>();
    // emit(state.copyWith(isLoading: true));
    useCases
        .getStories(
      pageKey: pageKey,
      orderBy: state.filters.orderBy,
      title: state.filters.title,
      tournamentId: tournamentId,
    )
        .listen((stories) {
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

  clearFilters() {
    emit(state.copyWith(
        filters: ExploreSearchFilters(orderBy: state.filters.orderBy)));
  }

  applyFilters({
    int? id,
    String? title,
    int? tournamentId,
    StoryOrderBy? orderBy,
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
