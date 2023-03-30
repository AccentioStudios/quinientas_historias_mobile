import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/team_entity.dart';
import '../entities/school_entity.dart';
import '../entities/story_entity.dart';
import '../entities/user_entity.dart';

part 'user_profile_dto.g.dart';

@JsonSerializable()
class UserProfileDto {
  UserProfileDto({
    required this.id,
    required this.firstName,
    this.lastName,
    this.nickname,
    required this.role,
    this.avatarUrl,
    required this.email,
    required this.favoriteStories,
    this.team,
    required this.previousTeams,
    this.school,
    required this.userReadsCount,
    required this.userTeamRank,
    required this.userTeamPoints,
  });

  factory UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);

  final int id;
  final String firstName;
  final String? lastName;
  final String? nickname;
  final String email;
  final String? avatarUrl;
  final Role role;
  final int userReadsCount;
  @JsonKey(defaultValue: [])
  final List<Story> favoriteStories;
  final int userTeamPoints;
  final int userTeamRank;
  final Team? team;
  final School? school;
  final List<Team> previousTeams;

  Map<String, dynamic> toJson() => _$UserProfileDtoToJson(this);
  User toEntity() => _$UserProfileDtoToEntity(this);
}

User _$UserProfileDtoToEntity(UserProfileDto instance) {
  return User(
    id: instance.id,
    firstName: instance.firstName,
    lastName: instance.lastName,
    email: instance.email,
    avatarUrl: instance.avatarUrl,
    role: UserRole(name: instance.role, userId: instance.id),
    team: instance.team,
    school: instance.school,
    // Empty because Dto does not have those fields
    active: true,
    favoriteStories: [],
    userFavorites: [],
    userPoints: [],
    userReads: [],
  );
}
