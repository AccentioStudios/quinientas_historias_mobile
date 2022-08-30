import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';

part 'invites_entity.g.dart';

@JsonSerializable()
class Invite {
  Invite({
    required this.id,
    required this.invitedEmail,
    required this.invitedType,
    required this.accepted,
  });
  final int id;
  final String invitedEmail;
  final UserType invitedType;
  final bool accepted;

  factory Invite.fromJson(Map<String, dynamic> json) => _$InvitesFromJson(json);

  Map<String, dynamic> toJson() => _$InvitesToJson(this);
}
