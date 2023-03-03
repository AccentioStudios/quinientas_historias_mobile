import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_point_entity.g.dart';

@JsonSerializable()
class UserPoint {
  UserPoint({
    this.id,
    this.userId,
    this.points,
    this.storyId,
    this.teamId,
  });

  factory UserPoint.fromJson(Map<String, dynamic> json) =>
      _$UserPointFromJson(json);

  final int? id;
  final int? userId;
  final int? points;
  final int? storyId;
  final int? teamId;

  Map<String, dynamic> toJson() => _$UserPointToJson(this);
}
