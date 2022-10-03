import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament_entity.g.dart';

@JsonSerializable()
class Tournament {
  Tournament({
    required this.id,
    this.title,
    this.active,
    this.desc,
    required this.createdAt,
    required this.updatedAt,
    required this.endsAt,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) =>
      _$TournamentFromJson(json);

  final int id;
  final String? title;
  final int? active;
  final String? desc;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime endsAt;

  Map<String, dynamic> toJson() => _$TournamentToJson(this);
}
