// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthRequest _$AuthRequestFromJson(Map<String, dynamic> json) => AuthRequest(
      credentials: json['credentials'] as Map<String, dynamic>,
      firebaseToken: json['firebaseToken'] as String?,
    );

Map<String, dynamic> _$AuthRequestToJson(AuthRequest instance) =>
    <String, dynamic>{
      'credentials': instance.credentials,
      'firebaseToken': instance.firebaseToken,
    };
