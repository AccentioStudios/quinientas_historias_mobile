import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/invites_entity.dart';

part 'accept_invite.dto.g.dart';

@JsonSerializable()
class AcceptInviteDto {
  AcceptInviteDto({
    required this.invite,
    this.user,
  });
  factory AcceptInviteDto.fromJson(Map<String, dynamic> json) =>
      _$AcceptInviteDtoFromJson(json);

  final Invite invite;
  final UserDto? user;

  Map<String, dynamic> toJson() => _$AcceptInviteDtoToJson(this);
}

@JsonSerializable()
class UserDto {
  UserDto({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.password,
    this.passwordConfirmation,
    this.avatarUrl,
    this.teamId,
    this.schoolId,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  final int? id;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? password;
  final String? passwordConfirmation;
  final String? avatarUrl;
  final String? teamId;
  final String? schoolId;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
