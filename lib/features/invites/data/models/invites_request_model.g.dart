// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invites_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitesRequest _$InvitesRequestFromJson(Map<String, dynamic> json) =>
    InvitesRequest(
      email: json['email'] as String,
      type: $enumDecode(_$UserTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$InvitesRequestToJson(InvitesRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'type': _$UserTypeEnumMap[instance.type],
    };

const _$UserTypeEnumMap = {
  UserType.reader: 'reader',
  UserType.prof: 'prof',
  UserType.captain: 'captain',
  UserType.unknown: 'unknown',
};
