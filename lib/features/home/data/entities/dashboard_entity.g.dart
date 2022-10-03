// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Dashboard _$DashboardFromJson(Map<String, dynamic> json) => Dashboard(
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      dailyChallenge: json['dailyChallenge'] == null
          ? null
          : DailyChallenge.fromJson(
              json['dailyChallenge'] as Map<String, dynamic>),
      exploreStories: (json['exploreStories'] as List<dynamic>?)
              ?.map((e) => Story.fromJson(e as Map<String, dynamic>))
              .toList() ??
          initialExploreStories,
      teamRank: json['teamRank'] as int?,
      schoolRank: json['schoolRank'] as int?,
      tournament: json['tournament'] == null
          ? null
          : Tournament.fromJson(json['tournament'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DashboardToJson(Dashboard instance) => <String, dynamic>{
      'user': instance.user,
      'dailyChallenge': instance.dailyChallenge,
      'exploreStories': instance.exploreStories,
      'teamRank': instance.teamRank,
      'schoolRank': instance.schoolRank,
      'tournament': instance.tournament,
    };
