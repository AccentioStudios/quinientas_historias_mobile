// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accept_invite.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcceptInviteDto _$AcceptInviteDtoFromJson(Map<String, dynamic> json) =>
    AcceptInviteDto(
      invite: Invite.fromJson(json['invite'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : UserDto.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AcceptInviteDtoToJson(AcceptInviteDto instance) =>
    <String, dynamic>{
      'invite': instance.invite,
      'user': instance.user,
    };

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      id: json['id'] as int?,
      username: json['username'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String,
      password: json['password'] as String?,
      passwordConfirmation: json['passwordConfirmation'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      teamId: json['teamId'] as String?,
      schoolId: json['schoolId'] as String?,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'password': instance.password,
      'passwordConfirmation': instance.passwordConfirmation,
      'avatarUrl': instance.avatarUrl,
      'teamId': instance.teamId,
      'schoolId': instance.schoolId,
    };
