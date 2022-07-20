// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      email: json['email'] as String,
      type: $enumDecodeNullable(_$UserTypeEnumMap, json['type']) ??
          UserType.unknown,
      score: json['score'] as int?,
      streak: json['streak'] as int?,
      bestStreak: json['bestStreak'] as int?,
      favoriteStories: (json['favoriteStories'] as List<dynamic>?)
          ?.map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
      team: json['team'] == null
          ? null
          : Team.fromJson(json['team'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatarUrl': instance.avatarUrl,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'type': _$UserTypeEnumMap[instance.type],
      'score': instance.score,
      'streak': instance.streak,
      'bestStreak': instance.bestStreak,
      'favoriteStories': instance.favoriteStories,
      'school': instance.school,
      'team': instance.team,
    };

const _$UserTypeEnumMap = {
  UserType.reader: 'reader',
  UserType.prof: 'prof',
  UserType.captain: 'captain',
  UserType.unknown: 'unknown',
};
