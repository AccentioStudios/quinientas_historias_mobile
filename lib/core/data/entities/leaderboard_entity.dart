import 'package:freezed_annotation/freezed_annotation.dart';

import '../entities/school_entity.dart';
import '../entities/team_entity.dart';
import '../entities/user_division_entity.dart';
import '../entities/user_entity.dart';

part 'leaderboard_entity.g.dart';

@JsonSerializable()
class Leaderboard {
  Leaderboard({
    required this.rankPlace,
    required this.userPoints,
    required this.userReads,
    this.userDivision,
    this.user,
    this.team,
    this.school,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardFromJson(json);

  final int rankPlace;
  final int userPoints;
  final int userReads;
  final UserDivision? userDivision;
  final User? user;
  final Team? team;
  final School? school;

  Map<String, dynamic> toJson() => _$LeaderboardToJson(this);
}
