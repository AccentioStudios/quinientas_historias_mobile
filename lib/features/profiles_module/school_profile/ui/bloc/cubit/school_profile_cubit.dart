import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/models/jwt_token_model.dart';
import 'package:quinientas_historias/core/helpers/secure_storage_helper.dart';
import 'package:quinientas_historias/core/mixins/stream_disposable.dart';
import 'package:quinientas_historias/features/profiles_module/school_profile/data/useCases/school_profile_usecases.dart';

import '../../../../../../core/data/entities/school_entity.dart';
import '../../../../../../core/data/entities/user_entity.dart';

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
      {required Function onSuccess, required Function onError}) async {
    final bool canEdit;
    final JWTTokenModel? sessionData =
        await SecureStorageHelper.getSessionData();
//Comparación para ver si soy profesor + es mi escuela, entonces canEdit = true, hacer lo mismo con TEAMPROFILE
    if (sessionData?.user.type == UserType.prof &&
        sessionData?.user.school!.id == schoolId) {
      canEdit = true;
    } else {
      canEdit = false;
    }

    emit(state.copyWith(
        isLoading: true, user: sessionData!.user, canEdit: canEdit));

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
