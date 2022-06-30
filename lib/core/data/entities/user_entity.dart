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
    required this.avatarUrl,
    required this.phoneNumber,
    required this.email,
    required this.type,
    required this.score,
    required this.streak,
    required this.bestStreak,
    required this.favoriteStories,
    required this.school,
    required this.team,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String id;
  final String firstName;
  final String lastName;
  final String avatarUrl;
  final String phoneNumber;
  final String email;
  @JsonKey(defaultValue: UserType.unknown)
  final UserType type;
  final int score;
  final int streak;
  final int bestStreak;
  final List<Story> favoriteStories;
  final School school;
  final Team team;

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

enum UserType {
  @JsonValue('reader')
  reader,
  @JsonValue('prof')
  prof,
  @JsonValue('writer')
  writer,
  unknown,
}
