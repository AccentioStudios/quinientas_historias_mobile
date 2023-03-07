import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_read_entity.g.dart';

@JsonSerializable()
class UserRead {
  UserRead({
    required this.userId,
    required this.storyId,
    this.teamId,
  });

  factory UserRead.fromJson(Map<String, dynamic> json) =>
      _$UserReadFromJson(json);

  final int userId;
  final int storyId;
  final int? teamId;

  Map<String, dynamic> toJson() => _$UserReadToJson(this);
}
