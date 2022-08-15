import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/features/profiles_module/school_profile/data/models/school_profile_model.dart';

part 'school_profile_state.dart';
part 'school_profile_cubit.freezed.dart';

class SchoolProfileCubit extends Cubit<SchoolProfileState> {
  SchoolProfileCubit({required this.schoolId})
      : super(const SchoolProfileState());

  final int schoolId;
}
