// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JWTTokenModel _$JWTTokenModelFromJson(Map<String, dynamic> json) =>
    JWTTokenModel(
      accessToken: json['accessToken'] as String?,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JWTTokenModelToJson(JWTTokenModel instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'user': instance.user,
    };
