import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/mixins/stream_disposable.dart';
import '../../data/useCases/challenges_usecases.dart';

part 'challenges_cubit.freezed.dart';
part 'challenges_state.dart';

class ChallengesCubit extends Cubit<ChallengesState> with StreamDisposable {
  ChallengesCubit({
    required this.challengesUseCases,
  }) : super(const ChallengesState());
  final ChallengesUseCases challengesUseCases;

  Future<void> getDashboard() async {
    // var completer = Completer<void>();

    // emit(state.copyWith(loading: true));
    // homeUseCases.getDashboard().listen((Dashboard dashboard) async {
    //   emit(state.copyWith(dashboard: dashboard, loading: false));
    //   completer.complete();
    // }, onError: (error) {
    //   completer.completeError(error);
    // }).subscribe(this);
    // return completer.future;
  }
}
