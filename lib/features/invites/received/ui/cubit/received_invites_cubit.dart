import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/mixins/form_validation.dart';
import '../../../../../../core/mixins/stream_disposable.dart';
import '../../../../../core/data/entities/invites_entity.dart';
import '../../../data/models/verify_invite_code_request_model.dart';
import '../../../data/useCases/invites_usecases.dart';

part 'received_invites_cubit.freezed.dart';
part 'received_invites_state.dart';

class ReceivedInvitesCubit extends Cubit<ReceivedInvitesState>
    with StreamDisposable, FormValidation {
  ReceivedInvitesCubit({
    required this.invitesUseCases,
  }) : super(const ReceivedInvitesState());

  final InvitesUseCases invitesUseCases;

  validateCode(int inviteId, String code,
      {required Function onSuccess, required Function onError}) {
    emit(state.copyWith(isLoading: true, code: code));
    invitesUseCases
        .validateCode(
            VerifyInviteCodeRequest(code: state.code, inviteId: inviteId))
        .listen((invite) async {
      emit(state.copyWith(
        isLoading: false,
        invite: invite,
      ));
      onSuccess();
    }, onError: (error) {
      onError(error);
    }).subscribe(this);
  }
}
