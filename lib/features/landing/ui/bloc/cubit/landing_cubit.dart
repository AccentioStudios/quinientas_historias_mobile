import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'landing_state.dart';
part 'landing_cubit.freezed.dart';

class LandingCubit extends Cubit<LandingState> {
  LandingCubit() : super(const LandingState());

  void load() {}
}
