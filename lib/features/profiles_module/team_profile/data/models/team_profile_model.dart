import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/team_entity.dart';

part 'team_profile_model.g.dart';

@JsonSerializable()
class TeamProfile {
  TeamProfile({
    required this.team,
  });
  final Team team;

  factory TeamProfile.fromJson(Map<String, dynamic> json) =>
      _$TeamProfileFromJson(json);
  Map<String, dynamic> toJson() => _$TeamProfileToJson(this);
}
