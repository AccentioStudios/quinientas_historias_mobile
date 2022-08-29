import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/models/leaderboard_model.dart';

part 'team_entity.g.dart';

@JsonSerializable()
class Team {
  Team({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.score,
    this.leaderboard,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  final int id;
  final String name;
  final String? avatarUrl;
  final int? score;
  final List<LeaderboardModel>? leaderboard;

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
