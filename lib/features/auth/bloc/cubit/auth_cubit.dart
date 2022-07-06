import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/failures/failures.dart';
import 'package:quinientas_historias/features/auth/data/models/login_model.dart';
import 'package:quinientas_historias/features/auth/data/useCases/auth_usecases.dart';

import '../../../../core/mixins/stream_disposable.dart';
import '../../data/models/auth_error_model.dart';
import '../../data/models/auth_model.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> with StreamDisposable {
  AuthCubit({
    required this.authUseCases,
  }) : super(const AuthState());

  final AuthUseCases authUseCases;

  void login(LoginModel login,
      {required Function onError, required void Function() onSuccess}) {
    emit(state.copyWith(loading: true, authError: null));

    authUseCases
        .login(LoginModel(email: state.email, password: state.password))
        .listen((AuthModel authModel) {
      if (authModel.userId != null && authModel.accessToken != null) {
        if (authModel.userId!.isNotEmpty && authModel.accessToken!.isNotEmpty) {
          return onSuccess();
        } else {
          onError(CommonFailure(
              'Hubo un problema al recuperar los datos, intenta nuevamente'));
        }
      } else {
        onError(CommonFailure(
            'Hubo un problema al recuperar los datos, intenta nuevamente'));
      }
    }, onError: (error) {
      if (error is LoginFailure) {
        emit(state.copyWith(authError: error.authErrorModel));
      } else {
        onError(error);
      }
    }, onDone: () {
      emit(state.copyWith(loading: false));
    }).subscribe(this);
  }
}
