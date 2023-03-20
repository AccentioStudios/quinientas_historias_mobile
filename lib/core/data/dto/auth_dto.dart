import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../integrations/platform_environments.dart';

import '../entities/user_entity.dart';

part 'auth_dto.g.dart';

@JsonSerializable()
class AuthDto {
  AuthDto({
    this.accessToken,
    this.refreshToken,
    required this.payload,
  });

  final String? accessToken;
  final String? refreshToken;
  final JwtPayload payload;

  factory AuthDto.decode(Map<String, dynamic> map) {
    try {
      final String key = PlatformEnvironment.jwtSecret.toString();

      String accessToken = map['access_token'].toString();
      String refreshToken = map['refresh_token'].toString();
      final jwtSecret = SecretKey(key);
      final jwt = JWT.verify(accessToken, jwtSecret);
      final jwtUserData = jwt.payload;

      return AuthDto(
          accessToken: accessToken,
          refreshToken: refreshToken,
          payload: JwtPayload.fromJson(jwtUserData as Map<String, dynamic>));
    } catch (error) {
      rethrow;
    }
  }

  factory AuthDto.fromJson(Map<String, dynamic> json) =>
      _$AuthDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AuthDtoToJson(this);
}

@JsonSerializable()
class JwtPayload {
  JwtPayload(
      {required this.id,
      required this.firstName,
      this.lastName,
      this.nickname,
      this.avatarUrl,
      required this.email,
      required this.role,
      this.active});

  factory JwtPayload.fromJson(Map<String, dynamic> json) =>
      _$JwtPayloadFromJson(json);

  final int id;
  final String firstName;
  final String? lastName;
  final String? nickname;
  final String? avatarUrl;
  final String email;
  @JsonKey(defaultValue: Role.public)
  final Role role;
  @JsonKey(defaultValue: false)
  final bool? active;

  Map<String, dynamic> toJson() => _$JwtPayloadToJson(this);
  User toUserEntity() => _$JwtPayloadToUserEntity(this);
}

User _$JwtPayloadToUserEntity(JwtPayload instance) {
  return User(
    id: instance.id,
    firstName: instance.firstName,
    lastName: instance.lastName,
    email: instance.email,
    avatarUrl: instance.avatarUrl,
    role: instance.role,
    // Empty because JwtPayload does not have those fields
    team: null,
    school: null,
    active: true,
    favoriteStories: [],
    userFavorites: [],
    userPoints: [],
    userReads: [],
  );
}
