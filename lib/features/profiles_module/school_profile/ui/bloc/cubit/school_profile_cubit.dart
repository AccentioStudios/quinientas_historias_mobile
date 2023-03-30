import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/data/dto/school_profile_dto.dart';
import '../../../../../../core/mixins/stream_disposable.dart';
import '../../../data/useCases/school_profile_usecases.dart';

part 'school_profile_cubit.freezed.dart';
part 'school_profile_state.dart';

class SchoolProfileCubit extends Cubit<SchoolProfileState>
    with StreamDisposable {
  SchoolProfileCubit(
      {required this.schoolProfileUseCases, required this.schoolId})
      : super(const SchoolProfileState());

  final SchoolProfileUseCases schoolProfileUseCases;
  final int schoolId;

  Future<void> getProfile() async {
    var completer = Completer<void>();
    emit(state.copyWith(isLoading: true));
    schoolProfileUseCases.getSchool(schoolId).listen((school) async {
      emit(state.copyWith(isLoading: false, school: school));
      completer.complete();
    }, onError: (error) {
      completer.completeError(error);
      emit(state.copyWith(isLoading: false));
    }).subscribe(this);
    return completer.future;
  }
}
