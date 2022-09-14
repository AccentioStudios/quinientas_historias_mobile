import '../../../../core/data/models/jwt_token_model.dart';
import '../../../../core/integrations/api_service.dart';
import '../models/iforgot_request_model.dart';
import '../models/iforgot_response_model.dart';
import '../models/login_model.dart';
import '../models/verify_otp_code_request_model.dart';
import '../models/verify_otp_code_response_model.dart';

class AuthRepository with ApiService {
  Stream<JWTTokenModel> login(LoginModel login) async* {
    yield* appApi.post('v1/auth/login', data: login.toJson()).handleJson(
        mapper: (data) {
      JWTTokenModel authModel = JWTTokenModel.decode(data);
      appApi.setAuth(authModel);
      return authModel;
    });
  }

  Stream<IForgotResponse> resetPassword(IForgotRequest iForgotModel) async* {
    yield* appApi
        .post('v1/auth/resetPassword', data: iForgotModel.toJson())
        .handleJson(mapper: (data) {
      final response = IForgotResponse.fromMap(data);
      return response;
    });
  }

  Stream<VerifyOtpCodeResponse> verifyOtpCode(
      VerifyOtpCodeRequest verifyOtpCodeRequest) async* {
    yield* appApi
        .post('v1/auth/verifyResetPasswordOTPCode',
            data: verifyOtpCodeRequest.toJson())
        .handleJson(mapper: (data) {
      final response = VerifyOtpCodeResponse.fromMap(data);
      return response;
    });
  }

  Stream<bool> createNewPassword(IForgotRequest iForgotRequest) async* {
    yield* appApi
        .post('v1/auth/createNewPassword', data: iForgotRequest.toJson())
        .handle(mapper: (data) {
      final response = data == 'true';
      return response;
    });
  }
}
