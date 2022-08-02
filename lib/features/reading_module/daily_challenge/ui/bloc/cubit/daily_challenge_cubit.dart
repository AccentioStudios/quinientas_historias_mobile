import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/data/entities/daily_challenge_entity.dart';
import '../../../../../../core/data/entities/story_entity.dart';
import '../../../../../../core/data/entities/story_progress_entity.dart';
import '../../../../../../core/mixins/stream_disposable.dart';
import '../../../data/useCases/daily_challenge_usecases.dart';

part 'daily_challenge_cubit.freezed.dart';
part 'daily_challenge_state.dart';

class DailyChallengeCubit extends Cubit<DailyChallengeState>
    with StreamDisposable {
  DailyChallengeCubit({
    required this.dailyChallengeUseCases,
  }) : super(DailyChallengeState(data: DailyChallenge()));

  final DailyChallengeUseCases dailyChallengeUseCases;

  void getData(bool isFromPullRefresh,
      {bool softGenerateNewChallenge = false,
      bool forceGenerateNewChallenge = false,
      DailyChallenge? dailyChallengeOnMemory,
      Function(DailyChallenge data)? onSuccess,
      required Function? onError}) {
    emit(state.copyWith(loading: true));

    if (dailyChallengeOnMemory != null &&
        isFromPullRefresh == false &&
        softGenerateNewChallenge == false &&
        forceGenerateNewChallenge == false) {
      emit(state.copyWith(data: dailyChallengeOnMemory, loading: false));
      if (verifyIfHasChallenge()) {
        emit(state.copyWith(
            storyHovered: dailyChallengeOnMemory
                .challenge[_searchIndexCurrentReadingBook()].story));
      }
    } else {
      dailyChallengeUseCases
          .getData(
        softGenerateNewChallenge: softGenerateNewChallenge,
        forceGenerateNewChallenge: forceGenerateNewChallenge,
      )
          .listen((DailyChallenge data) {
        emit(state.copyWith(data: data));
        if (data.challenge.isNotEmpty) {
          emit(state.copyWith(
              storyHovered:
                  data.challenge[_searchIndexCurrentReadingBook()].story));
        } else {
          emit(state.copyWith(storyHovered: null));
        }

        if (onSuccess != null) onSuccess(data);
      }, onError: (error) {
        if (onError != null) onError(error);
      }, onDone: () {
        emit(state.copyWith(loading: false));
      }).subscribe(this);
    }
  }

  int _searchIndexCurrentReadingBook() {
    try {
      return state.data.challenge.indexOf(state.data.challenge
          .firstWhere((element) => element.status == StoryStatus.reading));
    } catch (error) {
      return 0;
    }
  }

  void changeStoryHovered(int index) {
    final Story story = state.data.challenge[index].story;
    emit(state.copyWith(storyHovered: story));
  }

  bool verifyIfHasChallenge() {
    if (state.data.challenge.isNotEmpty == true) {
      return true;
    }
    return false;
  }
}
