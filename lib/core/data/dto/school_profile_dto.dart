import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/leaderboard_entity.dart';
import '../entities/school_entity.dart';
import '../entities/team_entity.dart';
import '../entities/tournament_entity.dart';

part 'school_profile_dto.g.dart';

@JsonSerializable()
class SchoolProfileDto {
  SchoolProfileDto({
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

  factory SchoolProfileDto.fromJson(Map<String, dynamic> json) =>
      _$SchoolProfileDtoFromJson(json);

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

  Map<String, dynamic> toJson() => _$SchoolProfileDtoToJson(this);
  School toEntity() => _$SchoolProfileDtoToEntity(this);
}

School _$SchoolProfileDtoToEntity(SchoolProfileDto instance) {
  return School(
    id: instance.id,
    name: instance.name,
    avatarUrl: instance.avatarUrl,
    // Empty because Dto does not have those fields
  );
}
