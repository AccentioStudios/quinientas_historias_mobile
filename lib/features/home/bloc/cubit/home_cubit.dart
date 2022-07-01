import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/mixins/stream_disposable.dart';

import '../../../../core/data/entities/user_entity.dart';
import '../../data/useCases/home_usecases.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> with StreamDisposable {
  HomeCubit({
    required this.homeUseCases,
  }) : super(const HomeState());
  final HomeUseCases homeUseCases;

  void loadUserData({required Function? onError}) {
    emit(state.copyWith(loading: true));
    homeUseCases.userData().listen((User user) {
      emit(state.copyWith(user: user));
    }, onError: (error) {
      if (onError != null) onError(error);
    }, onDone: () {
      emit(state.copyWith(loading: false));
    }).subscribe(this);
  }
}
