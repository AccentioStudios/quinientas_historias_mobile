// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/invites_entity.dart';

part 'accept_invite.dto.g.dart';

@JsonSerializable()
class AcceptInviteDto {
  AcceptInviteDto({
    required this.invite,
    this.user,
    this.firebaseToken,
  });
  factory AcceptInviteDto.fromJson(Map<String, dynamic> json) =>
      _$AcceptInviteDtoFromJson(json);

  final Invite invite;
  final UserDto? user;
  final String? firebaseToken;

  Map<String, dynamic> toJson() => _$AcceptInviteDtoToJson(this);
}

@JsonSerializable()
class UserDto {
  UserDto({
    this.id,
    this.username,
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
  final String? username;
  final String? firstName;
  final String? lastName;
  final String email;
  final String? password;
  final String? passwordConfirmation;
  final String? avatarUrl;
  final int? teamId;
  final int? schoolId;

  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  UserDto copyWith({
    int? id,
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? passwordConfirmation,
    String? avatarUrl,
    int? teamId,
    int? schoolId,
  }) {
    return UserDto(
      id: id ?? this.id,
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      teamId: teamId ?? this.teamId,
      schoolId: schoolId ?? this.schoolId,
    );
  }
}
