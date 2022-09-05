import 'package:freezed_annotation/freezed_annotation.dart';

part 'division_entity.g.dart';

@JsonSerializable()
class Division {
  Division({
    required this.name,
    required this.level,
    required this.scoreToAchieve,
  });

  factory Division.fromJson(Map<String, dynamic> json) =>
      _$DivisionFromJson(json);

  final String name;
  final int level;
  final int scoreToAchieve;

  Map<String, dynamic> toJson() => _$DivisionToJson(this);
}
