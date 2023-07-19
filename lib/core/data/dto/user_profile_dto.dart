// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/team_entity.dart';
import '../../../features/quiz/domain/entities/quiz_items.entity.dart';
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
    required this.pendingQuizItemsToReview,
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
  final List<QuizItem> pendingQuizItemsToReview;

  Map<String, dynamic> toJson() => _$UserProfileDtoToJson(this);
  User toEntity() => _$UserProfileDtoToEntity(this);

  UserProfileDto copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? nickname,
    String? email,
    String? avatarUrl,
    Role? role,
    int? userReadsCount,
    List<Story>? favoriteStories,
    int? userTeamPoints,
    int? userTeamRank,
    Team? team,
    School? school,
    List<Team>? previousTeams,
    List<QuizItem>? pendingQuizItemsToReview,
  }) {
    return UserProfileDto(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      nickname: nickname ?? this.nickname,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      userReadsCount: userReadsCount ?? this.userReadsCount,
      favoriteStories: favoriteStories ?? this.favoriteStories,
      userTeamPoints: userTeamPoints ?? this.userTeamPoints,
      userTeamRank: userTeamRank ?? this.userTeamRank,
      team: team ?? this.team,
      school: school ?? this.school,
      previousTeams: previousTeams ?? this.previousTeams,
      pendingQuizItemsToReview:
          pendingQuizItemsToReview ?? this.pendingQuizItemsToReview,
    );
  }
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
