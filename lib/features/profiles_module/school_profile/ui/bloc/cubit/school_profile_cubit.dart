import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/mixins/stream_disposable.dart';
import 'package:quinientas_historias/features/profiles_module/school_profile/data/useCases/school_profile_usecases.dart';

import '../../../../../../core/data/entities/school_entity.dart';

part 'school_profile_state.dart';
part 'school_profile_cubit.freezed.dart';

class SchoolProfileCubit extends Cubit<SchoolProfileState>
    with StreamDisposable {
  SchoolProfileCubit(
      {required this.schoolProfileUseCases, required this.schoolId})
      : super(const SchoolProfileState());

  final SchoolProfileUseCases schoolProfileUseCases;

  final int schoolId;

  getSchoolProfileData(
      {required Function onSuccess, required Function onError}) {
    emit(state.copyWith(isLoading: true));

    schoolProfileUseCases.getSchool(schoolId).listen((school) {
      emit(state.copyWith(data: school));
      onSuccess();
    }, onError: (error) {
      onError(error);
    }, onDone: () {
      emit(state.copyWith(isLoading: false));
    }).subscribe(this);
  }
}
