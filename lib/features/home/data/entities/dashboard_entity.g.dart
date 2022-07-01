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
    );

Map<String, dynamic> _$DashboardToJson(Dashboard instance) => <String, dynamic>{
      'user': instance.user,
      'dailyChallenge': instance.dailyChallenge,
    };
