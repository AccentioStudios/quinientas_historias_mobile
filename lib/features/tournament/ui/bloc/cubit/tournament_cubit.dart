import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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

  getLeaderboard(int pageKey, String filter,
      {Function(ListPage<LeaderboardModel>)? onSuccess,
      Function(Object)? onError}) async {
    await Future.delayed(const Duration(seconds: 2));

    tournamentUseCases.getLeaderboard(pageKey, filter).listen((leaderboard) {
      if (onSuccess != null) onSuccess(leaderboard);
    }, onError: (error) {
      if (onError != null) onError(error);
    }).subscribe(this);
  }

  getCurrentTournament({Function? onSuccess, Function? onError}) async {
    emit(state.copyWith(tournamentIsLoading: true, tournament: null));
    await Future.delayed(const Duration(seconds: 2));

    tournamentUseCases.getCurrentTournament().listen((tournament) {
      emit(state.copyWith(tournament: tournament));
      if (onSuccess != null) onSuccess();
    }, onError: (error) {
      if (onError != null) onError(error);
    }, onDone: () {
      emit(state.copyWith(tournamentIsLoading: false));
    }).subscribe(this);
  }
}
