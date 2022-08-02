import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/data/entities/daily_challenge_entity.dart';
import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';
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

  void getDashboard(
      {Function(Dashboard dashboard)? onSuccess, required Function? onError}) {
    emit(state.copyWith(loading: true));
    homeUseCases.getDashboard().listen((Dashboard dashboard) {
      emit(state.copyWith(
          user: dashboard.user,
          dailyChallenge: dashboard.dailyChallenge,
          exploreStories: dashboard.exploreStories));
      if (onSuccess != null) onSuccess(dashboard);
    }, onError: (error) {
      if (onError != null) onError(error);
    }, onDone: () {
      emit(state.copyWith(loading: false));
    }).subscribe(this);
  }

  void saveDailyChallenge(DailyChallenge dailyChallenge) {
    emit(state.copyWith(dailyChallenge: dailyChallenge));
  }
}
