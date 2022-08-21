import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_entity.g.dart';

@JsonSerializable()
class Tournament {
  Tournament({
    required this.title,
    required this.initDate,
    required this.endDate,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) =>
      _$TournamentFromJson(json);

  final String title;
  final DateTime initDate;
  final DateTime endDate;

  Map<String, dynamic> toJson() => _$TournamentToJson(this);
}
