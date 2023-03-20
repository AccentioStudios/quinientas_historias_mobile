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
    required this.role,
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
  final String firstName;
  final String? lastName;
  final String? nickname;
  final String? avatarUrl;
  final String email;
  @JsonKey(defaultValue: false)
  final bool? active;
  @JsonKey(defaultValue: Role.public)
  final Role role;
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
