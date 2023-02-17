import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openid_client/openid_client_io.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/data/models/jwt_token_model.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/helpers/secure_storage_helper.dart';
import '../../../../../core/integrations/platform_environments.dart';
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

  Future<Map<String, dynamic>> oidcAuthenticate({
    required String authorizationEndpoint,
    required String clientId,
    required String redirectUri,
    required String scopes,
  }) async {
    final authUrl =
        '$authorizationEndpoint?response_type=code&client_id=$clientId&redirect_uri=$redirectUri&scope=$scopes&state=${const Uuid().v4()}';

    final result = await FlutterWebAuth.authenticate(
        url: authUrl, callbackUrlScheme: 'qh-auth');

    final accessToken = Uri.parse(result).queryParameters['accessToken'];
    final idToken = Uri.parse(result).queryParameters['idToken'];

    return {'accessToken': accessToken, 'idToken': idToken};
  }

  Future<Credential?> getRedirectResult(Client client,
      {List<String> scopes = const []}) async {
    return null;
  }

  void loginIntoTelle(
      {required String? firebaseToken,
      required Map<String, dynamic> credentials,
      required Function onError,
      required void Function() onSuccess}) async {
    emit(state.copyWith(loading: true, httpFailure: null));
    await Future.delayed(const Duration(seconds: 1));

    final authRequest = AuthRequest(
      credentials: credentials,
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
      required void Function(Map<String, dynamic> credentials)
          onSuccess}) async {
    try {
      const clientId = PlatformEnvironment.oidcClientId;
      final issuer =
          await Issuer.discover(Uri.parse(PlatformEnvironment.oidcDiscoverUrl));
      const scopes = 'openid email profile';
      String redirectUri = PlatformEnvironment.oidcRedirectUri;
      if (kIsWeb) redirectUri = '$redirectUri/web';

      var credentials = await oidcAuthenticate(
        clientId: clientId,
        redirectUri: redirectUri,
        scopes: scopes,
        authorizationEndpoint: issuer.metadata.authorizationEndpoint.toString(),
      );

      if (credentials['accessToken'] != null &&
          credentials['idToken'] != null) {
        return onSuccess(credentials);
      } else {
        onError(HttpFailure(
            message:
                'Hubo un problema al recuperar los datos, intenta nuevamente'));
      }
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
