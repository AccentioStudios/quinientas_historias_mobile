import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_profile_state.dart';
part 'team_profile_cubit.freezed.dart';

class TeamProfileCubit extends Cubit<TeamProfileState> {
  TeamProfileCubit() : super(TeamProfileState.initial());
}
