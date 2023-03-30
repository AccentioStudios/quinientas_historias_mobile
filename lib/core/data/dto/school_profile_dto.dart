import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/leaderboard_entity.dart';
import '../entities/school_entity.dart';

part 'school_profile_dto.g.dart';

@JsonSerializable()
class SchoolProfileDto {
  SchoolProfileDto({
    required this.id,
    required this.name,
    required this.active,
    required this.schoolPoints,
    required this.schoolReads,
    this.avatarUrl,
    this.canEdit,
    this.leaderboard,
  });

  factory SchoolProfileDto.fromJson(Map<String, dynamic> json) =>
      _$SchoolProfileDtoFromJson(json);

  final int id;
  final String name;
  final String? avatarUrl;
  final bool active;
  final bool? canEdit;
  final int schoolPoints;
  final int schoolReads;
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
