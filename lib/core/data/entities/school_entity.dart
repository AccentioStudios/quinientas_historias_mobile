import 'package:freezed_annotation/freezed_annotation.dart';
import 'leaderboard_entity.dart';

part 'school_entity.g.dart';

@JsonSerializable()
class School {
  School({
    required this.id,
    required this.name,
    this.score,
    this.avatarUrl,
    this.readed,
    this.canEdit,
    this.leaderboard,
  });

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

  final int id;
  final String name;
  final int? score;
  final String? avatarUrl;
  final int? readed;
  final bool? canEdit;

  final List<Leaderboard>? leaderboard;

  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}
