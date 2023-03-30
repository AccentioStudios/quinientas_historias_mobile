import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/team_entity.dart';
import 'favorite_entity.dart';
import 'school_entity.dart';
import 'story_entity.dart';
import 'user_point_entity.dart';
import 'user_read_entity.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.firstName,
    this.lastName,
    this.nickname,
    this.active,
    this.role,
    this.avatarUrl,
    required this.email,
    required this.userPoints,
    required this.userReads,
    required this.userFavorites,
    required this.favoriteStories,
    this.team,
    this.school,
    this.diceCount,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  @JsonKey(defaultValue: '')
  final String firstName;
  @JsonKey(defaultValue: '')
  final String? lastName;
  @JsonKey(defaultValue: '')
  final String? nickname;
  final String? avatarUrl;
  final String email;
  @JsonKey(defaultValue: false)
  final bool? active;
  final UserRole? role;
  @JsonKey(defaultValue: [])
  final List<UserPoint> userPoints;
  @JsonKey(defaultValue: [])
  final List<UserRead> userReads;
  @JsonKey(defaultValue: [])
  final List<Favorite> userFavorites;
  final Team? team;
  final School? school;

  final int? diceCount;
  @JsonKey(defaultValue: [])
  final List<Story> favoriteStories;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserRole {
  const UserRole({
    this.id,
    required this.userId,
    required this.name,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) =>
      _$UserRoleFromJson(json);

  final int? id;
  final int userId;
  @JsonKey(defaultValue: Role.reader)
  final Role name;
  Map<String, dynamic> toJson() => _$UserRoleToJson(this);
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
