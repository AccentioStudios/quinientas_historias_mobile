import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';
import 'package:quinientas_historias/core/helpers/secure_storage_helper.dart';

import '../../../../../core/data/entities/leaderboard_entity.dart';
import '../../../../../core/data/entities/tournament_entity.dart';
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

  getLeaderboard(int tournamentId, int pageKey, String filter,
      {Function(ListPage<Leaderboard>)? onSuccess,
      Function(Object)? onError}) async {
    emit(state.copyWith(leaderboardIsLoading: true, listPage: null));
    tournamentUseCases.getLeaderboard(tournamentId, pageKey, filter).listen(
        (leaderboard) {
      if (onSuccess != null) onSuccess(leaderboard);
      emit(state.copyWith(leaderboardIsLoading: false, listPage: leaderboard));
    }, onError: (error) {
      if (onError != null) onError(error);
      emit(state.copyWith(leaderboardIsLoading: false, listPage: null));
    }).subscribe(this);
  }

  Future<void> getAllTournaments() async {
    var completer = Completer<void>();

    emit(state.copyWith(tournamentIsLoading: true, tournaments: []));
    tournamentUseCases.getAllTournaments().listen((tournaments) async {
      emit(state.copyWith(tournaments: tournaments));
      completer.complete();
    }, onError: (error) {
      completer.completeError(error);
    }, onDone: () {
      emit(state.copyWith(tournamentIsLoading: false));
    }).subscribe(this);
    return completer.future;
  }
}
