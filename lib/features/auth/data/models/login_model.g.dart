// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRequest _$AuthRequestFromJson(Map<String, dynamic> json) => AuthRequest(
      user: User2.fromJson(json['user'] as Map<String, dynamic>),
      firebaseToken: json['firebaseToken'] as String?,
    );

Map<String, dynamic> _$AuthRequestToJson(AuthRequest instance) =>
    <String, dynamic>{
      'user': instance.user,
      'firebaseToken': instance.firebaseToken,
    };
