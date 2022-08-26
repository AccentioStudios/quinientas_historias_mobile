// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invites_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitesResponse _$InvitesResponseFromJson(Map<String, dynamic> json) =>
    InvitesResponse(
      email: json['email'] as String,
      type: $enumDecode(_$UserTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$InvitesResponseToJson(InvitesResponse instance) =>
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
