import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/school_entity.dart';
import 'package:quinientas_historias/core/data/entities/team_entity.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';

part 'invites_entity.g.dart';

@JsonSerializable()
class Invite {
  Invite({
    this.id,
    required this.inviterUserId,
    this.teamId,
    this.schoolId,
    required this.invitedEmail,
    this.invitedId,
    this.invitedFirstName,
    this.invitedLastName,
    required this.invitedRole,
    required this.accepted,
    required this.code,
    this.inviter,
    this.invited,
    this.team,
    this.school,
    this.tournamentId,
  });
  final int? id;
  final int inviterUserId;
  final int? teamId;
  final int? schoolId;
  final int? tournamentId;
  final int? invitedId;
  final String invitedEmail;
  final String? invitedFirstName;
  final String? invitedLastName;
  @JsonKey(defaultValue: Role.reader)
  final Role invitedRole;
  final bool accepted;
  final String? code;
  final User? inviter;
  final User? invited;
  final Team? team;
  final School? school;

  factory Invite.fromJson(Map<String, dynamic> json) => _$InviteFromJson(json);

  Map<String, dynamic> toJson() => _$InviteToJson(this);
}
