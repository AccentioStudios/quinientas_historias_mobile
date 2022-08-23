import 'package:freezed_annotation/freezed_annotation.dart';

part 'school_entity.g.dart';

@JsonSerializable()
class School {
  School({
    required this.id,
    required this.name,
    this.score,
    this.avatarUrl,
  });

  factory School.fromJson(Map<String, dynamic> json) => _$SchoolFromJson(json);

  final int id;
  final String name;
  final int? score;
  final String? avatarUrl;

  Map<String, dynamic> toJson() => _$SchoolToJson(this);
}
