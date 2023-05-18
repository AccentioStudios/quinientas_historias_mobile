import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/mixins/stream_disposable.dart';
import '../../../data/entities/dashboard_entity.dart';
import '../../../data/useCases/home_usecases.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> with StreamDisposable {
  HomeCubit({
    required this.homeUseCases,
  }) : super(const HomeState());
  final HomeUseCases homeUseCases;

  Future<void> getDashboard() async {
    var completer = Completer<void>();

    emit(state.copyWith(loading: true, error: null));
    homeUseCases.getDashboard().listen((Dashboard dashboard) async {
      emit(state.copyWith(dashboard: dashboard, loading: false, error: null));
      completer.complete();
    }, onError: (error) {
      emit(state.copyWith(error: error, loading: false));
      completer.completeError(error);
    }).subscribe(this);
    return completer.future;
  }

  // void saveDailyChallenge(DailyChallenge dailyChallenge) {
  //   emit(state.copyWith(
  //       dashboard: state.dashboard?.copyWith(dailyChallenge: dailyChallenge)));
  // }
}
