import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/features/invites/data/models/invites_request_model.dart';

import '../../../../../../core/data/entities/user_entity.dart';
import '../../../../../../core/mixins/stream_disposable.dart';
import '../../../data/useCases/invites_usecases.dart';

part 'invites_state.dart';
part 'invites_cubit.freezed.dart';

class InvitesCubit extends Cubit<InvitesState> with StreamDisposable {
  InvitesCubit({
    required this.invitesUseCases,
  }) : super(const InvitesState());

  final InvitesUseCases invitesUseCases;

  sendInvite(InvitesRequest request,
      {required Function onSuccess, required Function onError}) {
    emit(state.copyWith(isLoading: true));

    invitesUseCases.sendInvite(request).listen((userProfile) {
      onSuccess();
    }, onError: (error) {
      onError(error);
    }, onDone: () {
      emit(state.copyWith(isLoading: false));
    }).subscribe(this);
  }
}
