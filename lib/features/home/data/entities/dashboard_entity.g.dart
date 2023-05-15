// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dashboard _$DashboardFromJson(Map<String, dynamic> json) => Dashboard(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      mySummary: json['mySummary'] as List<dynamic>,
      recomendedStories: (json['recomendedStories'] as List<dynamic>)
          .map((e) =>
              RecomendedStoriesDasboardDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DashboardToJson(Dashboard instance) => <String, dynamic>{
      'user': instance.user,
      'mySummary': instance.mySummary,
      'recomendedStories': instance.recomendedStories,
    };

RecomendedStoriesDasboardDto _$RecomendedStoriesDasboardDtoFromJson(
        Map<String, dynamic> json) =>
    RecomendedStoriesDasboardDto(
      recomendationTitle: json['recomendationTitle'] as String,
      recomendationDescription: json['recomendationDescription'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RecomendedStoriesDasboardDtoToJson(
        RecomendedStoriesDasboardDto instance) =>
    <String, dynamic>{
      'recomendationTitle': instance.recomendationTitle,
      'recomendationDescription': instance.recomendationDescription,
      'data': instance.data,
    };

MySummaryGroup _$MySummaryGroupFromJson(Map<String, dynamic> json) =>
    MySummaryGroup(
      summaryTitle: json['summaryTitle'] as String,
      summaryDescription: json['summaryDescription'] as String,
      groupType: $enumDecode(_$GroupTypeEnumMap, json['groupType']),
      groupName: json['groupName'] as String,
      groupId: json['groupId'] as int,
      points: json['points'] as int,
      userReads: json['userReads'] as int,
      rankPlace: json['rankPlace'] as int,
      avatarUrl: json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$MySummaryGroupToJson(MySummaryGroup instance) =>
    <String, dynamic>{
      'summaryTitle': instance.summaryTitle,
      'summaryDescription': instance.summaryDescription,
      'groupType': _$GroupTypeEnumMap[instance.groupType]!,
      'groupName': instance.groupName,
      'groupId': instance.groupId,
      'points': instance.points,
      'userReads': instance.userReads,
      'rankPlace': instance.rankPlace,
      'avatarUrl': instance.avatarUrl,
    };

const _$GroupTypeEnumMap = {
  GroupType.school: 'school',
  GroupType.team: 'team',
};

MySummaryChallenge _$MySummaryChallengeFromJson(Map<String, dynamic> json) =>
    MySummaryChallenge(
      summaryTitle: json['summaryTitle'] as String,
      summaryDescription: json['summaryDescription'] as String,
      challengeType: $enumDecode(_$ChallengeTypeEnumMap, json['challengeType']),
      userChallengeId: json['userChallengeId'] as int,
      steps: json['steps'] as int?,
      stepsCompleted: json['stepsCompleted'] as int?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$MySummaryChallengeToJson(MySummaryChallenge instance) =>
    <String, dynamic>{
      'summaryTitle': instance.summaryTitle,
      'summaryDescription': instance.summaryDescription,
      'challengeType': _$ChallengeTypeEnumMap[instance.challengeType]!,
      'userChallengeId': instance.userChallengeId,
      'steps': instance.steps,
      'stepsCompleted': instance.stepsCompleted,
      'url': instance.url,
    };

const _$ChallengeTypeEnumMap = {
  ChallengeType.steps: 'steps',
  ChallengeType.minigame: 'minigame',
  ChallengeType.questions: 'questions',
};

MySummary _$MySummaryFromJson(Map<String, dynamic> json) => MySummary(
      summaryTitle: json['summaryTitle'] as String,
      summaryDescription: json['summaryDescription'] as String,
    );

Map<String, dynamic> _$MySummaryToJson(MySummary instance) => <String, dynamic>{
      'summaryTitle': instance.summaryTitle,
      'summaryDescription': instance.summaryDescription,
    };
