import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/helpers/secure_storage_helper.dart';
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

    emit(state.copyWith(loading: true));
    homeUseCases.getDashboard().listen((Dashboard dashboard) async {
      emit(state.copyWith(dashboard: dashboard, loading: false));
      completer.complete();
    }, onError: (error) {
      completer.completeError(error);
    }).subscribe(this);
    return completer.future;
  }

  // void saveDailyChallenge(DailyChallenge dailyChallenge) {
  //   emit(state.copyWith(
  //       dashboard: state.dashboard?.copyWith(dailyChallenge: dailyChallenge)));
  // }
}
