import 'package:freezed_annotation/freezed_annotation.dart';

part 'team_entity.g.dart';

@JsonSerializable()
class Team {
  Team({
    required this.id,
    required this.name,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  final String id;
  final String name;

  Map<String, dynamic> toJson() => _$TeamToJson(this);
}
