// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invites_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invite _$InviteFromJson(Map<String, dynamic> json) => Invite(
      id: json['id'] as int?,
      inviterUserId: json['inviterUserId'] as int,
      teamId: json['teamId'] as int?,
      schoolId: json['schoolId'] as int?,
      invitedEmail: json['invitedEmail'] as String,
      invitedId: json['invitedId'] as int?,
      invitedFirstName: json['invitedFirstName'] as String?,
      invitedLastName: json['invitedLastName'] as String?,
      invitedRole: $enumDecodeNullable(_$RoleEnumMap, json['invitedRole']) ??
          Role.reader,
      accepted: json['accepted'] as bool,
      code: json['code'] as String?,
      inviter: json['inviter'] == null
          ? null
          : User.fromJson(json['inviter'] as Map<String, dynamic>),
      invited: json['invited'] == null
          ? null
          : User.fromJson(json['invited'] as Map<String, dynamic>),
      team: json['team'] == null
          ? null
          : Team.fromJson(json['team'] as Map<String, dynamic>),
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InviteToJson(Invite instance) => <String, dynamic>{
      'id': instance.id,
      'inviterUserId': instance.inviterUserId,
      'teamId': instance.teamId,
      'schoolId': instance.schoolId,
      'invitedId': instance.invitedId,
      'invitedEmail': instance.invitedEmail,
      'invitedFirstName': instance.invitedFirstName,
      'invitedLastName': instance.invitedLastName,
      'invitedRole': _$RoleEnumMap[instance.invitedRole]!,
      'accepted': instance.accepted,
      'code': instance.code,
      'inviter': instance.inviter,
      'invited': instance.invited,
      'team': instance.team,
      'school': instance.school,
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
