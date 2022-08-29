// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invites_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invite _$InvitesFromJson(Map<String, dynamic> json) => Invite(
      id: json['id'] as int,
      invitedEmail: json['invitedEmail'] as String,
      invitedType: $enumDecode(_$UserTypeEnumMap, json['invitedType']),
      accepted: json['accepted'] as bool,
    );

Map<String, dynamic> _$InvitesToJson(Invite instance) => <String, dynamic>{
      'id': instance.id,
      'invitedEmail': instance.invitedEmail,
      'invitedType': _$UserTypeEnumMap[instance.invitedType],
      'accepted': instance.accepted,
    };

const _$UserTypeEnumMap = {
  UserType.reader: 'reader',
  UserType.prof: 'prof',
  UserType.captain: 'captain',
  UserType.unknown: 'unknown',
};
