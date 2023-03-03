import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';
import 'package:quinientas_historias/core/helpers/secure_storage_helper.dart';

import '../../../../../core/data/entities/tournament_entity.dart';
import '../../../../../core/data/models/leaderboard_model.dart';
import '../../../../../core/data/models/list_page.dart';
import '../../../../../core/mixins/stream_disposable.dart';
import '../../../data/useCases/tournament_usecases.dart';

part 'tournament_cubit.freezed.dart';
part 'tournament_state.dart';

class TournamentCubit extends Cubit<TournamentState> with StreamDisposable {
  TournamentCubit({required this.tournamentUseCases})
      : super(const TournamentState());
  final TournamentUseCases tournamentUseCases;

  hideOrShowMyTeamTab() async {
    final user = await SecureStorageHelper.getSessionData();
    if (user?.role != Role.captain && user?.role != Role.reader) {
      emit(state.copyWith(teamTabShowed: false));
    }
  }

  getLeaderboard(int pageKey, String filter,
      {Function(ListPage<LeaderboardModel>)? onSuccess,
      Function(Object)? onError}) async {
    emit(state.copyWith(leaderboardIsLoading: true, listPage: null));
    await Future.delayed(const Duration(milliseconds: 500));

    tournamentUseCases.getLeaderboard(pageKey, filter).listen((leaderboard) {
      if (onSuccess != null) onSuccess(leaderboard);
      emit(state.copyWith(leaderboardIsLoading: false, listPage: leaderboard));
    }, onError: (error) {
      if (onError != null) onError(error);
      emit(state.copyWith(leaderboardIsLoading: false, listPage: null));
    }).subscribe(this);
  }

  getCurrentTournament({Function? onSuccess, Function? onError}) async {
    emit(state.copyWith(tournamentIsLoading: true, tournament: null));
    tournamentUseCases.getCurrentTournament().listen((tournament) async {
      emit(state.copyWith(tournament: tournament));
      if (onSuccess != null) onSuccess();
    }, onError: (error) {
      if (onError != null) onError(error);
    }, onDone: () {
      emit(state.copyWith(tournamentIsLoading: false));
    }).subscribe(this);
  }
}
