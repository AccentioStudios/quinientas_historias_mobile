// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_division_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDivision _$UserDivisionFromJson(Map<String, dynamic> json) => UserDivision(
      id: json['id'] as int?,
      userId: json['userId'] as int?,
      divisionId: json['divisionId'] as int?,
      tournamentId: json['tournamentId'] as int?,
      division: json['division'] == null
          ? null
          : Division.fromJson(json['division'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDivisionToJson(UserDivision instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'divisionId': instance.divisionId,
      'tournamentId': instance.tournamentId,
      'division': instance.division,
    };
