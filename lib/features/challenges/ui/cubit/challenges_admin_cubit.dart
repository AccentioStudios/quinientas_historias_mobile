import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/mixins/stream_disposable.dart';
import '../../../../core/data/entities/challenge_sar_entity.dart';
import '../../../../core/failures/failures.dart';
import '../../data/dto/register_new_challenge_response.dto.dart';
import '../../data/useCases/challenges_usecases.dart';

part 'challenges_admin_cubit.freezed.dart';
part 'challenges_admin_state.dart';

class ChallengesAdminCubit extends Cubit<ChallengesAdminState>
    with StreamDisposable {
  ChallengesAdminCubit({
    required this.challengesUseCases,
  }) : super(const ChallengesAdminState());
  final ChallengesUseCases challengesUseCases;

  Future<void> initNewChallenge() async {
    emit(state.copyWith(
      challenge: ChallengeSar(
        name: '',
        url: '',
        probability: 0,
        required: false,
        tournaments: [],
        steps: 0,
        params: [],
        triggers: [],
        active: true,
        points: null,
        weight: 0,
      ),
    ));
  }

  Future<void> saveChanges({
    String? name,
    String? url,
    double? probability,
    bool? required,
    List<int>? tournaments,
    int? steps,
    List<String>? params,
    List<String>? triggers,
    int? points,
  }) async {
    emit(state.copyWith(
        challenge: state.challenge!.copyWith(
      name: name ?? state.challenge!.name,
      url: url ?? state.challenge!.url,
      probability: probability ?? state.challenge!.probability,
      required: required ?? state.challenge!.required,
      tournaments: tournaments ?? state.challenge!.tournaments,
      steps: steps ?? state.challenge!.steps,
      params: params ?? state.challenge!.params,
      triggers: triggers ?? state.challenge!.triggers,
    )));

    debugPrint(state.challenge!.toJson().toString());
  }

  Future<RegisterNewChallengeResponseDto> registerNewChallenge() async {
    final completer = Completer<RegisterNewChallengeResponseDto>();
    if (state.challenge != null) {
      emit(state.copyWith(registeringChallenge: true, error: null));
      challengesUseCases.registerNewChallenge(state.challenge!).listen(
          (challenge) {
        emit(state.copyWith(registeringChallenge: false, error: null));
        completer.complete(challenge);
      }, onError: (e) {
        completer.completeError(e);
        emit(state.copyWith(registeringChallenge: false, error: e));
      }).subscribe(this);
    }
    return completer.future;
  }
}
