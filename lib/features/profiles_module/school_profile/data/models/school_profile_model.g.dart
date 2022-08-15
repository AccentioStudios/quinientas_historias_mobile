// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'school_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchoolProfile _$SchoolProfileFromJson(Map<String, dynamic> json) =>
    SchoolProfile(
      school: School.fromJson(json['school'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SchoolProfileToJson(SchoolProfile instance) =>
    <String, dynamic>{
      'school': instance.school,
    };
