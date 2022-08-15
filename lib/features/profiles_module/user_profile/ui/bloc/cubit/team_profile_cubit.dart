import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/features/profiles_module/school_profile/data/models/school_profile_model.dart';

part 'team_profile_state.dart';
part 'team_profile_cubit.freezed.dart';

class UserProfileCubit extends Cubit<TeamProfileState> {
  UserProfileCubit({required this.userId}) : super(const TeamProfileState());

  final int userId;
}
