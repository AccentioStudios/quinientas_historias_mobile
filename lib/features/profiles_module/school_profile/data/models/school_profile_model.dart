import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/data/entities/school_entity.dart';
part 'school_profile_model.g.dart';

@JsonSerializable()
class SchoolProfile {
  SchoolProfile({
    required this.school,
  });
  final School school;

  factory SchoolProfile.fromJson(Map<String, dynamic> json) =>
      _$SchoolProfileFromJson(json);
  Map<String, dynamic> toJson() => _$SchoolProfileToJson(this);
}
