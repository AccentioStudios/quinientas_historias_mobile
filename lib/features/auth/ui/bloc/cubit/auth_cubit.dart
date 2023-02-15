import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openid_client/openid_client_io.dart' as io;
import 'package:openid_client/openid_client_io.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/data/entities/user_2_entity.dart';
import '../../../../../core/data/models/jwt_token_model.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/helpers/secure_storage_helper.dart';
import '../../../../../core/mixins/stream_disposable.dart';
import '../../../../../core/utils/constants.dart';
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

  Future<Credential> authenticate(Client client,
      {List<String> scopes = const []}) async {
    // create a function to open a browser with an url
    urlLauncher(String url) async {
      var uri = Uri.parse(url);
      if (await canLaunchUrl(uri) || Platform.isAndroid) {
        await launchUrl(uri, mode: LaunchMode.inAppWebView);
      } else {
        throw 'Could not launch $url';
      }
    }

    // create an authenticator
    var authenticator = io.Authenticator(
      client,
      scopes: scopes,
      port: 4000,
      urlLancher: urlLauncher,
      htmlPage: '<html>'
          '<h1>Redireccionando...</h1>'
          '<script>window.close();</script>'
          '<style>'
          'html {'
          'background-color: #101C29;'
          'color: white;'
          'font-family: sans-serif;'
          'font-size: 0.5rem;'
          'text-align: center;'
          'padding: 10px;'
          '}'
          'h1 {'
          'padding: 10px;'
          'display: flex;'
          'justify-content: center;'
          'align-items: center;'
          'justify-items: center;'
          'height: 100%;'
          '}'
          '</style>'
          '</html>',
    );

    // starts the authentication
    var c = await authenticator.authorize();

    // close the webview when finished
    if (Platform.isAndroid || Platform.isIOS) {
      closeInAppWebView();
    }

    return c;
  }

  Future<Credential?> getRedirectResult(Client client,
      {List<String> scopes = const []}) async {
    return null;
  }

  void loginIntoTelle(
      {required String? firebaseToken,
      required UserInfo userInfo,
      required Function onError,
      required void Function() onSuccess}) async {
    emit(state.copyWith(loading: true, httpFailure: null));
    // await Future.delayed(const Duration(seconds: 2));

    final authRequest = AuthRequest(
      user: User2(
          name: userInfo.name,
          givenName: userInfo.givenName,
          familyName: userInfo.familyName,
          nickname: userInfo.nickname,
          email: userInfo.email),
      firebaseToken: firebaseToken,
    );

    authUseCases.login(authRequest).listen((JWTTokenModel jwtTokenModel) {
      if (jwtTokenModel.accessToken != null) {
        if (jwtTokenModel.accessToken!.isNotEmpty) {
          SecureStorageHelper.saveSession(jwtTokenModel);
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
    // SecureStorageHelper.saveSession(JWTTokenModel(
    //     accessToken: res.accessToken,
    //     user: User(
    //         email: user.email,
    //         firstName: user.name,
    //         lastName: user.familyName,
    //         avatarUrl: user.picture.toString())));
  }

  void wpOpenIdLogin(
      {required Function onError,
      required void Function(UserInfo userInfo) onSuccess}) async {
    try {
      const _clientId = 'DXjSKvZOEzjkTffTaIDOJAqazRDrWjSI';
      const _clientSecret = 'qQNZuzYxGGouhHbPbqvcVGqwUkYjVrLx';
      final _issuer = await Issuer.discover(Constants.openIDDiscoverUri);
      const _scopes = <String>['openid'];
      const _logoutUrl = '';

      var client = Client(_issuer, "DXjSKvZOEzjkTffTaIDOJAqazRDrWjSI",
          clientSecret: _clientSecret);

      var c = await authenticate(client, scopes: _scopes);

      var userInfo = await c.getUserInfo();

      return onSuccess(userInfo);
    } catch (error) {
      emit(
        state.copyWith(
          loading: false,
          httpFailure: HttpFailure(error: FailureType.unauthorized),
        ),
      );
      onError(HttpFailure(error: FailureType.unauthorized));
    }
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
