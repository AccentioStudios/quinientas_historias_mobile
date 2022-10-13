import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/data/models/jwt_token_model.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/mixins/stream_disposable.dart';
import '../../../data/models/iforgot_request_model.dart';
import '../../../data/models/login_model.dart';
import '../../../data/models/verify_otp_code_request_model.dart';
import '../../../data/useCases/auth_usecases.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> with StreamDisposable {
  AuthCubit({
    required this.authUseCases,
  }) : super(const AuthState());

  final AuthUseCases authUseCases;

  void login(
      {required String email,
      required String password,
      required String firebaseToken,
      required Function onError,
      required void Function() onSuccess}) {
    emit(state.copyWith(loading: true, httpFailure: null));

    final authRequest = AuthRequest(
      email: email,
      password: password,
      firebaseToken: firebaseToken,
    );

    authUseCases.login(authRequest).listen((JWTTokenModel authModel) {
      if (authModel.accessToken != null) {
        if (authModel.accessToken!.isNotEmpty) {
          return onSuccess();
        } else {
          onError(HttpFailure(
              message:
                  'Hubo un problema al recuperar los datos, intenta nuevamente'));
        }
      } else {
        onError(HttpFailure(
            message:
                'Hubo un problema al recuperar los datos, intenta nuevamente'));
      }
    }, onError: (error) {
      if (error is HttpFailure) {
        emit(state.copyWith(httpFailure: error));
      }
      onError(error);
    }, onDone: () {
      emit(state.copyWith(loading: false));
    }).subscribe(this);
  }

  void resetPassword(
      {required Function()? onSuccess, required Function? onError}) {
    emit(state.copyWith(loading: true));

    final request = IForgotRequest(email: state.email);

    authUseCases.resetPassword(request).listen((response) {
      emit(state.copyWith(token: response.token));
      if (onSuccess != null) onSuccess();
    }, onError: (error) {
      if (onError != null) onError(error);
    }, onDone: () {
      emit(state.copyWith(loading: false));
    }).subscribe(this);
  }

  void verifyOtp({required Function()? onSuccess, required Function? onError}) {
    emit(state.copyWith(loading: true));

    if (state.code.length < 4) {
      if (onError != null) {
        onError(HttpFailure(
            message: 'Introduce el codigo de verificacíon.',
            error: FailureType.invalidCode));
        emit(state.copyWith(loading: false));
        return;
      }
    }

    var request = VerifyOtpCodeRequest(code: state.code, token: state.token);

    authUseCases.verifyOtpCode(request).listen((response) {
      if (response.isValid) {
        if (onSuccess != null) onSuccess();
        return;
      }
      if (onError != null) onError(false);
      return;
    }, onError: (error) {
      if (onError != null) onError(error);
    }, onDone: () {
      emit(state.copyWith(loading: false));
    }).subscribe(this);
  }

  void createNewPassword(String newPassword, String passwordConfirmation,
      {required Function()? onSuccess, required Function? onError}) {
    emit(state.copyWith(loading: true));

    final request = IForgotRequest(
        password: newPassword,
        passwordConfirmation: passwordConfirmation,
        email: state.email,
        code: state.code,
        token: state.token);

    authUseCases.createNewPassword(request).listen((isValid) {
      if (isValid) {
        if (onSuccess != null) onSuccess();
        return;
      }
      if (onError != null) onError(false);
      return;
    }, onError: (error) {
      if (onError != null) onError(error);
    }, onDone: () {
      emit(state.copyWith(loading: false));
    }).subscribe(this);
  }

  setEmail(String email) {
    emit(state.copyWith(email: email));
  }

  setCodeAndToken(String code, String token) {
    emit(state.copyWith(code: code, token: token));
  }

  bool validateEmail(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  bool validatePasswords(String password, String confirmPassword) {
    if (password == confirmPassword) {
      return true;
    }
    return false;
  }
}
