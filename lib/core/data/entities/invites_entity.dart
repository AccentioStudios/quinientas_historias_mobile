import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/school_entity.dart';
import 'package:quinientas_historias/core/data/entities/team_entity.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';

part 'invites_entity.g.dart';

@JsonSerializable()
class Invite {
  Invite({
    this.id,
    required this.invitedEmail,
    required this.invitedType,
    this.inviter,
    this.team,
    this.school,
    required this.accepted,
  });
  final int? id;
  final String invitedEmail;
  final UserType invitedType;
  final User? inviter;
  final Team? team;
  final School? school;
  final int accepted;

  factory Invite.fromJson(Map<String, dynamic> json) => _$InviteFromJson(json);

  Map<String, dynamic> toJson() => _$InviteToJson(this);
}
