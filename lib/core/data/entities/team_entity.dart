import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/tournament_entity.dart';

import 'school_entity.dart';

part 'team_entity.g.dart';

@JsonSerializable()
class Team {
  Team({
    required this.id,
    required this.name,
    this.avatarUrl,
    this.score,
    this.readed,
    this.school,
    this.canEdit,
    this.tournament,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  final int id;
  final String name;
  final String? avatarUrl;
  final int? score;
  final int? readed;
  final School? school;
  final bool? canEdit;
  final Tournament? tournament;

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
