// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      email: json['email'] as String,
      type: $enumDecodeNullable(_$UserTypeEnumMap, json['type']) ??
          UserType.unknown,
      score: (json['score'] as num).toDouble(),
      streak: (json['streak'] as num).toDouble(),
      bestStreak: (json['bestStreak'] as num).toDouble(),
      favoritePosts: (json['favoritePosts'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      school: School.fromJson(json['school'] as Map<String, dynamic>),
      team: Team.fromJson(json['team'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'type': _$UserTypeEnumMap[instance.type],
      'score': instance.score,
      'streak': instance.streak,
      'bestStreak': instance.bestStreak,
      'favoritePosts': instance.favoritePosts,
      'school': instance.school,
      'team': instance.team,
    };

const _$UserTypeEnumMap = {
  UserType.reader: 'reader',
  UserType.prof: 'prof',
  UserType.writer: 'writer',
  UserType.unknown: 'unknown',
};
