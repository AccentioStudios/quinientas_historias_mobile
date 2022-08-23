import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_entity.g.dart';

@JsonSerializable()
class Team {
  Team({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.score,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  final int id;
  final String name;
  final String? avatarUrl;
  final int? score;

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
