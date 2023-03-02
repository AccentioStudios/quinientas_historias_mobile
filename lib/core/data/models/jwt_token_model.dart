import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../integrations/platform_environments.dart';

import '../entities/user_entity.dart';

part 'jwt_token_model.g.dart';

@JsonSerializable()
class JWTTokenModel {
  JWTTokenModel({
    this.accessToken,
    this.refreshToken,
    required this.user,
  });

  final String? accessToken;
  final String? refreshToken;
  final User user;

  factory JWTTokenModel.decode(Map<String, dynamic> map) {
    try {
      final String key = PlatformEnvironment.jwtSecret.toString();

      String accessToken = map['access_token'].toString();
      String refreshToken = map['refresh_token'].toString();
      final jwtSecret = SecretKey(key);
      final jwt = JWT.verify(accessToken, jwtSecret);
      final jwtUserData = jwt.payload;

      return JWTTokenModel(
          accessToken: accessToken,
          refreshToken: refreshToken,
          user: User.fromJson(jwtUserData as Map<String, dynamic>));
    } catch (error) {
      rethrow;
    }
  }

  factory JWTTokenModel.fromJson(Map<String, dynamic> json) =>
      _$JWTTokenModelFromJson(json);

  Map<String, dynamic> toJson() => _$JWTTokenModelToJson(this);
}
