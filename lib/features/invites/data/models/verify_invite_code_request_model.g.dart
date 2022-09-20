// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_invite_code_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyInviteCodeRequest _$VerifyInviteCodeRequestFromJson(
        Map<String, dynamic> json) =>
    VerifyInviteCodeRequest(
      email: json['email'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$VerifyInviteCodeRequestToJson(
        VerifyInviteCodeRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'code': instance.code,
    };
