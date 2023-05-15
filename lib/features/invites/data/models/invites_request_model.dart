import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/data/entities/user_entity.dart';

part 'invites_request_model.g.dart';

@JsonSerializable()
class CreateInviteDto {
  CreateInviteDto({
    this.invitedId,
    required this.email,
    required this.type,
    this.teamId,
    this.schoolId,
    this.tournamentId,
  });
  final int? invitedId;
  final String email;
  final Role type;
  final int? teamId;
  final int? schoolId;
  final int? tournamentId;

  factory CreateInviteDto.fromJson(Map<String, dynamic> json) =>
      _$CreateInviteDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CreateInviteDtoToJson(this);
}
