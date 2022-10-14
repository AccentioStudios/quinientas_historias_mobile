import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/data/entities/school_entity.dart';
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

  getSchoolProfileData(
      {required Function onSuccess, required Function onError}) async {
    emit(state.copyWith(isLoading: true));

    schoolProfileUseCases.getSchool(schoolId).listen((school) {
      emit(state.copyWith(school: school));
      onSuccess();
    }, onError: (error) {
      onError(error);
    }, onDone: () {
      emit(state.copyWith(isLoading: false));
    }).subscribe(this);
  }
}
