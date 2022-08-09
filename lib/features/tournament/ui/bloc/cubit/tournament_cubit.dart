import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_state.dart';
part 'tournament_cubit.freezed.dart';

class TournamentCubit extends Cubit<TournamentState> {
  TournamentCubit() : super(const TournamentState.initial());
}
