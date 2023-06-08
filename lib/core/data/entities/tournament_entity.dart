// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

import 'user_entity.dart';

part 'tournament_entity.g.dart';

@JsonSerializable()
class Tournament {
  Tournament({
    required this.id,
    this.name,
    this.active,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.startAt,
    required this.endsAt,
    this.users,
    this.usersCount,
    this.storyCount,
    this.participating,
    this.tagId,
    this.coverUrl,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) =>
      _$TournamentFromJson(json);

  final int id;
  final String? name;
  final bool? active;
  final String? description;
  final int? tagId;
  final String? coverUrl;
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

  Tournament copyWith({
    int? id,
    String? name,
    bool? active,
    String? description,
    int? tagId,
    String? coverUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? startAt,
    DateTime? endsAt,
    List<User>? users,
    int? usersCount,
    int? storyCount,
    bool? participating,
  }) {
    return Tournament(
      id: id ?? this.id,
      name: name ?? this.name,
      active: active ?? this.active,
      description: description ?? this.description,
      tagId: tagId ?? this.tagId,
      coverUrl: coverUrl ?? this.coverUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      startAt: startAt ?? this.startAt,
      endsAt: endsAt ?? this.endsAt,
      users: users ?? this.users,
      usersCount: usersCount ?? this.usersCount,
      storyCount: storyCount ?? this.storyCount,
      participating: participating ?? this.participating,
    );
  }
}
