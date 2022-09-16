import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/school_entity.dart';
import '../entities/team_entity.dart';
import '../entities/user_entity.dart';

part 'leaderboard_model.g.dart';

@JsonSerializable()
class LeaderboardModel {
  LeaderboardModel({
    required this.position,
    this.user,
    this.team,
    this.school,
    this.changePosition,
  });

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardModelFromJson(json);

  final int position;
  final User? user;
  final Team? team;
  final School? school;
  final LeaderboardChangePosition? changePosition;

  Map<String, dynamic> toJson() => _$LeaderboardModelToJson(this);
}

@JsonSerializable()
class LeaderboardChangePosition {
  LeaderboardChangePosition({
    required this.number,
    required this.type,
  });

  factory LeaderboardChangePosition.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardChangePositionFromJson(json);

  final int number;
  final LeaderboardChangePositionType type;

  Map<String, dynamic> toJson() => _$LeaderboardChangePositionToJson(this);
}

enum LeaderboardChangePositionType {
  positive,
  negative,
  neutral,
}
