import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';

import '../../../../core/data/entities/story_entity.dart';

part 'dashboard_entity.g.dart';

@JsonSerializable()
class Dashboard {
  Dashboard(
      {required this.user,
      required this.mySummary,
      required this.recomendedStories});
  User user;
  List<dynamic> mySummary;
  final List<RecomendedStoriesDasboardDto> recomendedStories;

  factory Dashboard.fromJson(Map<String, dynamic> json) =>
      _$DashboardFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardToJson(this);
}

@JsonSerializable()
class RecomendedStoriesDasboardDto {
  RecomendedStoriesDasboardDto(
      {required this.recomendationTitle,
      required this.recomendationDescription,
      required this.data});
  final String recomendationTitle;
  final String recomendationDescription;
  final List<Story> data;

  factory RecomendedStoriesDasboardDto.fromJson(Map<String, dynamic> json) =>
      _$RecomendedStoriesDasboardDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RecomendedStoriesDasboardDtoToJson(this);
}

@JsonSerializable()
class MySummaryGroup extends MySummary {
  MySummaryGroup(
      {required String summaryTitle,
      required String summaryDescription,
      required this.groupType,
      required this.groupName,
      required this.groupId,
      required this.points,
      required this.userReads,
      required this.rankPlace,
      this.avatarUrl})
      : super(
            summaryTitle: summaryTitle, summaryDescription: summaryDescription);
  final GroupType groupType;
  final String groupName;
  final int groupId;
  final int points;
  final int userReads;
  final int rankPlace;
  final String? avatarUrl;

  factory MySummaryGroup.fromJson(Map<String, dynamic> json) =>
      _$MySummaryGroupFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MySummaryGroupToJson(this);
}

@JsonSerializable()
class MySummaryChallenge extends MySummary {
  MySummaryChallenge({
    required String summaryTitle,
    required String summaryDescription,
    required this.challengeType,
    required this.userChallengeId,
    this.steps,
    this.stepsCompleted,
    this.url,
    User? user,
  }) : super(
            summaryTitle: summaryTitle, summaryDescription: summaryDescription);
  // Common
  final ChallengeType challengeType;
  final int userChallengeId;
  // Steps
  final int? steps;
  final int? stepsCompleted;
  // Minigame
  final String? url;
  // Questions

  factory MySummaryChallenge.fromJson(Map<String, dynamic> json) =>
      _$MySummaryChallengeFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$MySummaryChallengeToJson(this);
}

enum GroupType {
  @JsonValue('school')
  school,
  @JsonValue('team')
  team
}

enum ChallengeType {
  @JsonValue('steps')
  steps,
  @JsonValue('minigame')
  minigame,
  @JsonValue('questions')
  questions,
}

@JsonSerializable()
class MySummary {
  MySummary({required this.summaryTitle, required this.summaryDescription});
  final String summaryTitle;
  final String summaryDescription;

  factory MySummary.fromJson(Map<String, dynamic> json) =>
      _$MySummaryFromJson(json);
  Map<String, dynamic> toJson() => _$MySummaryToJson(this);
}
