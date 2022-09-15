import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/leaderboard_model.dart';

part 'school_entity.g.dart';

@JsonSerializable()
class School {
  School({
    required this.id,
    required this.name,
    this.score,
    this.avatarUrl,
    this.readings,
    this.teams,
  });

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

  final int id;
  final String name;
  final int? score;
  final String? avatarUrl;
  final int? readings;
  final List<LeaderboardModel>? teams;

  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}
