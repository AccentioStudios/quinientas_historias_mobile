import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/data/entities/user_entity.dart';
import '../../../../../../core/mixins/stream_disposable.dart';
import '../../../../../core/data/entities/invites_entity.dart';
import '../../../../../core/mixins/form_validation.dart';
import '../../../data/models/invites_request_model.dart';
import '../../../data/useCases/invites_usecases.dart';

part 'invites_cubit.freezed.dart';
part 'invites_state.dart';

class InvitesCubit extends Cubit<InvitesState>
    with StreamDisposable, FormValidation {
  InvitesCubit({
    required this.invitesUseCases,
  }) : super(const InvitesState());

  final InvitesUseCases invitesUseCases;

  validateForm(String s) {
    if (!validateEmail(s)) {
      emit(state.copyWith(formValidationError: true));
    } else {
      emit(state.copyWith(formValidationError: false));
    }
  }

  sendInvite(InvitesRequest request,
      {required Function onSuccess, required Function onError}) async {
    emit(state.copyWith(sendingInvite: true));
    await Future.delayed(const Duration(seconds: 1));

    invitesUseCases.sendInvite(request).listen((userProfile) {
      onSuccess();
      emit(state.copyWith(sendingInvite: false));
    }, onError: (error) {
      onError(error);
    }).subscribe(this);
  }

  getInvitations({required Function onSuccess, required Function onError}) {
    emit(state.copyWith(isLoading: true));

    invitesUseCases.getInvitations().listen((invites) {
      emit(state.copyWith(invites: invites, isLoading: false));
      onSuccess();
    }, onError: (error) {
      onError(error);
    }).subscribe(this);
  }
}
