import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/school_entity.dart';
import '../../../../core/data/entities/team_entity.dart';
import '../../../reading_module/data/entities/post_entity.dart';
part 'user_entity.g.dart';

@JsonSerializable()
class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.type,
    required this.score,
    required this.streak,
    required this.bestStreak,
    required this.favoritePosts,
    required this.school,
    required this.team,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  @JsonKey(defaultValue: UserType.unknown)
  final UserType type;
  final double score;
  final double streak;
  final double bestStreak;
  final List<Post> favoritePosts;
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
