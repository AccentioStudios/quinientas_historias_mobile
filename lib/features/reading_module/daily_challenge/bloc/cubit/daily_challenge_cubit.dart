import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/daily_challenge_entity.dart';
import 'package:quinientas_historias/core/mixins/stream_disposable.dart';

import '../../data/useCases/daily_challenge_usecases.dart';

part 'daily_challenge_state.dart';
part 'daily_challenge_cubit.freezed.dart';

class DailyChallengeCubit extends Cubit<DailyChallengeState>
    with StreamDisposable {
  DailyChallengeCubit({
    required this.dailyChallengeUseCases,
  }) : super(const DailyChallengeState());

  final DailyChallengeUseCases dailyChallengeUseCases;

  void getData({required Function? onError}) {
    emit(state.copyWith(loading: true));
    dailyChallengeUseCases.getData().listen((DailyChallenge data) {
      emit(state.copyWith(data: data));
    }, onError: (error) {
      if (onError != null) onError(error);
    }, onDone: () {
      emit(state.copyWith(loading: false));
    }).subscribe(this);
  }
}
