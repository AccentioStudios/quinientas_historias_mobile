import 'package:quinientas_historias/core/data/models/jwt_token_model.dart';
import 'package:quinientas_historias/features/auth/data/models/login_model.dart';

import '../models/iforgot_request_model.dart';
import '../models/iforgot_response_model.dart';
import '../models/verify_otp_code_request_model.dart';
import '../models/verify_otp_code_response_model.dart';
import '../repositories/auth_repository.dart';

class AuthUseCases {
  AuthUseCases({required this.repository});
  final AuthRepository repository;

  Stream<JWTTokenModel> login(AuthRequest login) async* {
    yield* repository.login(login);
  }

  Stream<IForgotResponse> resetPassword(IForgotRequest iForgotModel) async* {
    yield* repository.resetPassword(iForgotModel);
  }

  Stream<VerifyOtpCodeResponse> verifyOtpCode(
      VerifyOtpCodeRequest verifyOtpCodeRequest) async* {
    yield* repository.verifyOtpCode(verifyOtpCodeRequest);
  }

  Stream<bool> createNewPassword(IForgotRequest iForgotRequest) async* {
    yield* repository.createNewPassword(iForgotRequest);
  }
}
