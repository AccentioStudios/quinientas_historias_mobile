import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/data/entities/user_entity.dart';
import '../../../../../../core/mixins/form_validation.dart';
import '../../../../../../core/mixins/stream_disposable.dart';
import '../../../../../core/data/entities/school_entity.dart';
import '../../../../../core/data/entities/team_entity.dart';
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

  validateForm(String s) {
    if (!validateEmail(s)) {
      emit(state.copyWith(formValidationError: true));
    } else {
      emit(state.copyWith(formValidationError: false));
    }
  }

  validateCode(String email, String code,
      {required Function onSuccess, required Function onError}) {
    emit(state.copyWith(isLoading: true, code: code));
    invitesUseCases
        .validateCode(VerifyInviteCodeRequest(code: state.code, email: email))
        .listen((invites) {
      emit(state.copyWith(
        isLoading: false,
        whoIsInviting: invites.inviter,
        team: invites.team,
        school: invites.school,
      ));
      onSuccess();
    }, onError: (error) {
      onError(error);
      emit(state.copyWith(isLoading: false));
    }).subscribe(this);
  }
}
