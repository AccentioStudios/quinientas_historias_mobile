// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_division_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDivision _$UserDivisionFromJson(Map<String, dynamic> json) => UserDivision(
      next: json['next'] == null
          ? null
          : Division.fromJson(json['next'] as Map<String, dynamic>),
      current: json['current'] == null
          ? null
          : Division.fromJson(json['current'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDivisionToJson(UserDivision instance) =>
    <String, dynamic>{
      'next': instance.next,
      'current': instance.current,
    };
