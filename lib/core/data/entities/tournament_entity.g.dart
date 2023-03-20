// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tournament_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tournament _$TournamentFromJson(Map<String, dynamic> json) => Tournament(
      id: json['id'] as int,
      name: json['name'] as String?,
      active: json['active'] as bool?,
      desc: json['desc'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      startAt: DateTime.parse(json['startAt'] as String),
      endsAt: DateTime.parse(json['endsAt'] as String),
      users: (json['users'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      usersCount: json['usersCount'] as int?,
      storyCount: json['storyCount'] as int?,
      participating: json['participating'] as bool?,
    );

Map<String, dynamic> _$TournamentToJson(Tournament instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': instance.active,
      'desc': instance.desc,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'startAt': instance.startAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
      'users': instance.users,
      'usersCount': instance.usersCount,
      'storyCount': instance.storyCount,
      'participating': instance.participating,
    };
