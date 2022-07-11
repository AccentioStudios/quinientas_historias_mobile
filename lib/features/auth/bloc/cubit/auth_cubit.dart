import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/failures/auth_failure.dart';
import '../../../../core/failures/common_failure.dart';
import '../../../../core/mixins/stream_disposable.dart';
import '../../../../core/data/models/jwt_token_model.dart';
import '../../data/models/login_model.dart';
import '../../data/useCases/auth_usecases.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> with StreamDisposable {
  AuthCubit({
    required this.authUseCases,
  }) : super(const AuthState());

  final AuthUseCases authUseCases;

  void login(LoginModel login,
      {required Function onError, required void Function() onSuccess}) {
    emit(state.copyWith(loading: true, authFailure: null));

    authUseCases.login(login).listen((JWTTokenModel authModel) {
      if (authModel.accessToken != null) {
        if (authModel.accessToken!.isNotEmpty) {
          return onSuccess();
        } else {
          onError(CommonFailure(
              message:
                  'Hubo un problema al recuperar los datos, intenta nuevamente'));
        }
      } else {
        onError(CommonFailure(
            message:
                'Hubo un problema al recuperar los datos, intenta nuevamente'));
      }
    }, onError: (error) {
      if (error is AuthFailure) {
        emit(state.copyWith(authFailure: error));
      } else {
        onError(error);
      }
    }, onDone: () {
      emit(state.copyWith(loading: false));
    }).subscribe(this);
  }
}
