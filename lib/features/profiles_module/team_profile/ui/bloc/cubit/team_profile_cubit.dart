import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/data/entities/team_entity.dart';
import '../../../../../../core/data/entities/user_entity.dart';
import '../../../../../../core/data/models/jwt_token_model.dart';
import '../../../../../../core/helpers/secure_storage_helper.dart';
import '../../../../../../core/mixins/stream_disposable.dart';
import '../../../data/useCases/team_profile_usecases.dart';

part 'team_profile_cubit.freezed.dart';
part 'team_profile_state.dart';

class TeamProfileCubit extends Cubit<TeamProfileState> with StreamDisposable {
  TeamProfileCubit({required this.teamId, required this.teamProfileUseCases})
      : super(const TeamProfileState());

  final TeamProfileUseCases teamProfileUseCases;

  final int teamId;

  getTeamProfileData(
      {required Function onSuccess, required Function onError}) async {
    final bool canEdit;

    final JWTTokenModel? sessionData =
        await SecureStorageHelper.getSessionData();

    if (sessionData?.user.type == UserType.prof &&
        sessionData?.user.school!.id == teamId) {
      canEdit = true;
    } else {
      canEdit = false;
    }

    emit(state.copyWith(
        isLoading: true, user: sessionData!.user, canEdit: canEdit));

    teamProfileUseCases.getTeamProfile(teamId).listen((team) {
      emit(state.copyWith(team: team));
      onSuccess();
    }, onError: (error) {
      onError(error);
    }, onDone: () {
      emit(state.copyWith(isLoading: false));
    }).subscribe(this);
  }
}
