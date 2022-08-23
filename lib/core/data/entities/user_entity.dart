import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/story_entity.dart';

import '../../../../core/data/entities/school_entity.dart';
import '../../../../core/data/entities/team_entity.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.avatarUrl,
    this.phoneNumber,
    this.email,
    required this.type,
    this.score,
    this.readed,
    this.favoriteStories,
    this.school,
    this.team,
    this.streak,
    this.division,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String firstName;
  final String lastName;
  final String? avatarUrl;
  final String? phoneNumber;
  final String? email;
  @JsonKey(defaultValue: UserType.unknown)
  final UserType type;
  final int? streak;
  final int? readed;
  final int? score;
  final UserDivision? division;
  final List<Story>? favoriteStories;
  final School? school;
  final Team? team;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

enum UserType {
  @JsonValue('reader')
  reader,
  @JsonValue('prof')
  prof,
  @JsonValue('captain')
  captain,
  unknown,
}

@JsonSerializable()
class UserDivision {
  UserDivision({required this.level, this.scoreToAchieve});
  final int level;
  final int? scoreToAchieve;

  factory UserDivision.fromJson(Map<String, dynamic> json) =>
      _$UserDivisionFromJson(json);

  Map<String, dynamic> toJson() => _$UserDivisionToJson(this);
}
