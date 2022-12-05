import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quinientas_historias/core/data/entities/story_entity.dart';

import '../../../../core/data/entities/school_entity.dart';
import '../../../../core/data/entities/team_entity.dart';
import 'division_entity.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.email,
    this.type,
    this.score,
    this.readed,
    this.favoriteStories,
    this.school,
    this.team,
    this.streak,
    this.division,
    this.diceCount,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;
  final String? email;
  @JsonKey(defaultValue: UserType.unknown)
  final UserType? type;
  final int? streak;
  final int? readed;
  final int? score;
  final List<Story>? favoriteStories;
  final School? school;
  final Team? team;
  final UserDivision? division;
  final int? diceCount;

  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? avatarUrl,
    String? email,
    UserType? type,
    int? streak,
    int? readed,
    int? score,
    List<Story>? favoriteStories,
    School? school,
    Team? team,
    UserDivision? division,
    int? diceCount,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      email: email ?? this.email,
      type: type ?? this.type,
      streak: streak ?? this.streak,
      readed: readed ?? this.readed,
      score: score ?? this.score,
      favoriteStories: favoriteStories ?? this.favoriteStories,
      school: school ?? this.school,
      team: team ?? this.team,
      division: division ?? this.division,
      diceCount: diceCount ?? this.diceCount,
    );
  }
}

enum UserType {
  @JsonValue('reader')
  reader,
  @JsonValue('prof')
  prof,
  @JsonValue('captain')
  captain,
  @JsonValue('admin')
  admin,
  unknown,
}

@JsonSerializable()
class UserDivision {
  UserDivision({required this.current, this.next});
  final Division current;
  final Division? next;

  factory UserDivision.fromJson(Map<String, dynamic> json) =>
      _$UserDivisionFromJson(json);

  Map<String, dynamic> toJson() => _$UserDivisionToJson(this);
}
