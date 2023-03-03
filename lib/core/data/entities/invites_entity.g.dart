// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invites_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invite _$InviteFromJson(Map<String, dynamic> json) => Invite(
      id: json['id'] as int?,
      invitedEmail: json['invitedEmail'] as String,
      invitedType: $enumDecode(_$RoleEnumMap, json['invitedType']),
      inviter: json['inviter'] == null
          ? null
          : User.fromJson(json['inviter'] as Map<String, dynamic>),
      team: json['team'] == null
          ? null
          : Team.fromJson(json['team'] as Map<String, dynamic>),
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
      accepted: json['accepted'] as int,
    );

Map<String, dynamic> _$InviteToJson(Invite instance) => <String, dynamic>{
      'id': instance.id,
      'invitedEmail': instance.invitedEmail,
      'invitedType': _$RoleEnumMap[instance.invitedType]!,
      'inviter': instance.inviter,
      'team': instance.team,
      'school': instance.school,
      'accepted': instance.accepted,
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
