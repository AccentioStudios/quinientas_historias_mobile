// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invites_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateInviteDto _$CreateInviteDtoFromJson(Map<String, dynamic> json) =>
    CreateInviteDto(
      invitedId: json['invitedId'] as int?,
      email: json['email'] as String,
      type: $enumDecode(_$RoleEnumMap, json['type']),
      teamId: json['teamId'] as int?,
      schoolId: json['schoolId'] as int?,
      tournamentId: json['tournamentId'] as int?,
    );

Map<String, dynamic> _$CreateInviteDtoToJson(CreateInviteDto instance) =>
    <String, dynamic>{
      'invitedId': instance.invitedId,
      'email': instance.email,
      'type': _$RoleEnumMap[instance.type]!,
      'teamId': instance.teamId,
      'schoolId': instance.schoolId,
      'tournamentId': instance.tournamentId,
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
