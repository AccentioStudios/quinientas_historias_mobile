import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/school_entity.dart';

import '../../../../core/data/entities/team_entity.dart';
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

// @JsonSerializable()
// class UserDivision {
//   UserDivision({required this.current, this.next});
//   final Division current;
//   final Division? next;

//   factory UserDivision.fromJson(Map<String, dynamic> json) =>
//       _$UserDivisionFromJson(json);

//   Map<String, dynamic> toJson() => _$UserDivisionToJson(this);
// }
