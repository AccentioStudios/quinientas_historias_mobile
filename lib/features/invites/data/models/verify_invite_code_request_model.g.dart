// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_invite_code_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerifyInviteCodeRequest _$VerifyInviteCodeRequestFromJson(
        Map<String, dynamic> json) =>
    VerifyInviteCodeRequest(
      inviteId: json['inviteId'] as int,
      code: json['code'] as String,
    );

Map<String, dynamic> _$VerifyInviteCodeRequestToJson(
        VerifyInviteCodeRequest instance) =>
    <String, dynamic>{
      'inviteId': instance.inviteId,
      'code': instance.code,
    };
