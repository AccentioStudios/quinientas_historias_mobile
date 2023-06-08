import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/data/entities/tag_entity.dart';
import '../../../../../core/data/entities/tournament_entity.dart';
import '../../../../../core/mixins/stream_disposable.dart';
import '../../../data/dto/tournament.dto.dart';
import '../../../data/useCases/tournament_usecases.dart';

part 'tournament_admin_cubit.freezed.dart';
part 'tournament_admin_state.dart';

class TournamentAdminCubit extends Cubit<TournamentAdminState>
    with StreamDisposable {
  TournamentAdminCubit({required this.tournamentUseCases})
      : super(const TournamentAdminState());
  final TournamentUseCases tournamentUseCases;

  Future<void> initNewTournament() async {
    emit(state.copyWith(
      tournament: TournamentDto(
        name: '',
        description: '',
        tagId: 0,
        coverUrl: '',
        endsAt: DateTime.now(),
        startAt: DateTime.now(),
      ),
    ));
  }

  void loadTournament(Tournament tournament) {
    emit(state.copyWith(
      tournament: TournamentDto(
        id: tournament.id,
        name: tournament.name,
        description: tournament.description,
        tagId: tournament.tagId,
        coverUrl: tournament.coverUrl,
        endsAt: tournament.endsAt,
        startAt: tournament.startAt,
      ),
    ));
  }

  Future<void> saveChanges({
    String? name,
    String? description,
    String? coverUrl,
    int? tagId,
    DateTime? endsAt,
    DateTime? startAt,
  }) async {
    emit(state.copyWith(
        tournament: state.tournament!.copyWith(
      name: name ?? state.tournament!.name,
      description: description ?? state.tournament!.description,
      coverUrl: coverUrl ?? state.tournament!.coverUrl,
      tagId: tagId ?? state.tournament!.tagId,
      endsAt: endsAt ?? state.tournament!.endsAt,
      startAt: startAt ?? state.tournament!.startAt,
    )));

    debugPrint(state.tournament!.toJson().toString());
  }

  Future<void> editTournament() async {
    final completer = Completer<void>();
    if (state.tournament != null) {
      emit(state.copyWith(creatingTournamentLoading: true, error: null));
      tournamentUseCases.editTournament(state.tournament!).listen((tournament) {
        emit(state.copyWith(creatingTournamentLoading: false, error: null));
        completer.complete();
      }, onError: (e) {
        completer.completeError(e);
        emit(state.copyWith(creatingTournamentLoading: false, error: e));
      }).subscribe(this);
    }
    return completer.future;
  }

  Future<Tournament> registerNewTournament() async {
    final completer = Completer<Tournament>();
    if (state.tournament != null) {
      emit(state.copyWith(creatingTournamentLoading: true, error: null));
      tournamentUseCases.registerNewTournament(state.tournament!).listen(
          (tournament) {
        emit(state.copyWith(creatingTournamentLoading: false, error: null));
        completer.complete(tournament);
      }, onError: (e) {
        completer.completeError(e);
        emit(state.copyWith(creatingTournamentLoading: false, error: e));
      }).subscribe(this);
    }
    return completer.future;
  }

  Future<List<Tag>> getTagsFromWordpress() async {
    final completer = Completer<List<Tag>>();
    emit(state.copyWith(error: null));
    tournamentUseCases.getTagsFromWordpress().listen((tags) {
      emit(state.copyWith(error: null, tags: tags));
      completer.complete(tags);
    }, onError: (e) {
      completer.completeError(e);
      emit(state.copyWith(isLoading: false, error: e, tags: []));
    }).subscribe(this);

    return completer.future;
  }
}
