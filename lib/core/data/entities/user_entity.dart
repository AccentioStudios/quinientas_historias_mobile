import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/team_entity.dart';
import 'favorite_entity.dart';
import 'school_entity.dart';
import 'story_entity.dart';
import 'user_division_entity.dart';
import 'user_point_entity.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.firstName,
    this.lastName,
    this.nickname,
    required this.active,
    required this.role,
    this.avatarUrl,
    required this.email,
    this.userPoints,
    this.userDivisions,
    this.userFavorites,
    this.favoriteStories,
    this.teams,
    this.schools,
    this.diceCount,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String firstName;
  final String? lastName;
  final String? nickname;
  final String? avatarUrl;
  final String email;
  @JsonKey(defaultValue: false)
  final bool active;
  final Role role;
  final List<UserPoint>? userPoints;
  final List<Favorite>? userFavorites;
  final List<Story>? favoriteStories;
  final List<Team>? teams;
  final List<School>? schools;
  final List<UserDivision>? userDivisions;
  final int? diceCount;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

enum Role {
  @JsonValue('admin')
  admin,
  @JsonValue('public')
  public,
  @JsonValue('reader')
  reader,
  @JsonValue('captain')
  captain,
  @JsonValue('prof')
  prof,
  @JsonValue('jury')
  jury,
  @JsonValue('editor')
  editor,
}
