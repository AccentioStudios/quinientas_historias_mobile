import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/leaderboard_entity.dart';
import '../entities/school_entity.dart';
import '../entities/team_entity.dart';
import '../entities/tournament_entity.dart';

part 'team_profile_dto.g.dart';

@JsonSerializable()
class TeamProfileDto {
  TeamProfileDto({
    required this.id,
    required this.name,
    this.avatarUrl,
    required this.active,
    this.school,
    required this.tournament,
    this.canEdit,
    required this.teamPoints,
    required this.teamReads,
    this.leaderboard,
  });

  factory TeamProfileDto.fromJson(Map<String, dynamic> json) =>
      _$TeamProfileDtoFromJson(json);

  final int id;
  final String name;
  final String? avatarUrl;
  final bool active;
  final School? school;
  final Tournament tournament;
  final bool? canEdit;
  final int teamPoints;
  final int teamReads;
  final List<Leaderboard>? leaderboard;

  Map<String, dynamic> toJson() => _$TeamProfileDtoToJson(this);
  Team toEntity() => _$TeamProfileDtoToEntity(this);
}

Team _$TeamProfileDtoToEntity(TeamProfileDto instance) {
  return Team(
    id: instance.id,
    name: instance.name,
    avatarUrl: instance.avatarUrl,
    school: instance.school,
    // Empty because Dto does not have those fields
  );
}
