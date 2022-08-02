import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'school_profile_state.dart';
part 'school_profile_cubit.freezed.dart';

class SchoolProfileCubit extends Cubit<SchoolProfileState> {
  SchoolProfileCubit() : super(SchoolProfileState.initial());
}
