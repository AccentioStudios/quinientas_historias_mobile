import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/mixins/stream_disposable.dart';
import 'package:quinientas_historias/features/profiles_module/team_profile/data/useCases/team_profile_usecases.dart';

import '../../../../../../core/data/entities/team_entity.dart';
import '../../../data/models/team_profile_model.dart';

part 'team_profile_state.dart';
part 'team_profile_cubit.freezed.dart';

class TeamProfileCubit extends Cubit<TeamProfileState> with StreamDisposable {
  TeamProfileCubit({required this.teamId, required this.teamProfileUseCases})
      : super(const TeamProfileState());

  final TeamProfileUseCases teamProfileUseCases;

  final int teamId;

  getTeamProfileData({required Function onSuccess, required Function onError}) {
    emit(state.copyWith(isLoading: true));

    teamProfileUseCases.getTeamProfile(teamId).listen((team) {
      emit(state.copyWith(data: team));
      onSuccess();
    }, onError: (error) {
      onError(error);
    }, onDone: () {
      emit(state.copyWith(isLoading: false));
    }).subscribe(this);
  }
}
