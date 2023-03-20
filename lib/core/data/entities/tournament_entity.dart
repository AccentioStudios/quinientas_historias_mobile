import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_entity.dart';

part 'tournament_entity.g.dart';

@JsonSerializable()
class Tournament {
  Tournament({
    required this.id,
    this.name,
    this.active,
    this.desc,
    required this.createdAt,
    required this.updatedAt,
    required this.startAt,
    required this.endsAt,
    this.users,
    this.usersCount,
    this.storyCount,
    this.participating,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) =>
      _$TournamentFromJson(json);

  final int id;
  final String? name;
  final bool? active;
  final String? desc;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime startAt;
  final DateTime endsAt;
  @Default([])
  final List<User>? users;
  @Default(0)
  final int? usersCount;
  @Default(0)
  final int? storyCount;
  @Default(false)
  final bool? participating;

  Map<String, dynamic> toJson() => _$TournamentToJson(this);
}
