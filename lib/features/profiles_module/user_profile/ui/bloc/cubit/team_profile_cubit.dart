import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/features/profiles_module/user_profile/data/models/user_profile_model.dart';

part 'team_profile_state.dart';
part 'team_profile_cubit.freezed.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit({this.userId}) : super(const UserProfileState());

  final int? userId;
  // if not userId is provided then load user session profile
}
