// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invites_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitesRequest _$InvitesRequestFromJson(Map<String, dynamic> json) =>
    InvitesRequest(
      invitedId: json['invitedId'] as int?,
      email: json['email'] as String,
      type: $enumDecode(_$RoleEnumMap, json['type']),
      teamId: json['teamId'] as int?,
      schoolId: json['schoolId'] as int?,
    );

Map<String, dynamic> _$InvitesRequestToJson(InvitesRequest instance) =>
    <String, dynamic>{
      'invitedId': instance.invitedId,
      'email': instance.email,
      'type': _$RoleEnumMap[instance.type]!,
      'teamId': instance.teamId,
      'schoolId': instance.schoolId,
    };

const _$RoleEnumMap = {
  Role.admin: 'admin',
  Role.public: 'public',
  Role.reader: 'reader',
  Role.captain: 'captain',
  Role.prof: 'prof',
  Role.jury: 'jury',
  Role.editor: 'editor',
};
