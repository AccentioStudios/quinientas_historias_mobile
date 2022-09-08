// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      email: json['email'] as String?,
      type: $enumDecodeNullable(_$UserTypeEnumMap, json['type']) ??
          UserType.unknown,
      score: json['score'] as int?,
      readed: json['readed'] as int?,
      favoriteStories: (json['favoriteStories'] as List<dynamic>?)
          ?.map((e) => Story.fromJson(e as Map<String, dynamic>))
          .toList(),
      school: json['school'] == null
          ? null
          : School.fromJson(json['school'] as Map<String, dynamic>),
      team: json['team'] == null
          ? null
          : Team.fromJson(json['team'] as Map<String, dynamic>),
      streak: json['streak'] as int?,
      division: json['division'] == null
          ? null
          : UserDivision.fromJson(json['division'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatarUrl': instance.avatarUrl,
      'email': instance.email,
      'type': _$UserTypeEnumMap[instance.type],
      'streak': instance.streak,
      'readed': instance.readed,
      'score': instance.score,
      'favoriteStories': instance.favoriteStories,
      'school': instance.school,
      'team': instance.team,
      'division': instance.division,
    };

const _$UserTypeEnumMap = {
  UserType.reader: 'reader',
  UserType.prof: 'prof',
  UserType.captain: 'captain',
  UserType.admin: 'admin',
  UserType.unknown: 'unknown',
};

UserDivision _$UserDivisionFromJson(Map<String, dynamic> json) => UserDivision(
      current: Division.fromJson(json['current'] as Map<String, dynamic>),
      next: Division.fromJson(json['next'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDivisionToJson(UserDivision instance) =>
    <String, dynamic>{
      'current': instance.current,
      'next': instance.next,
    };
