import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/data/entities/user_entity.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfile {
  UserProfile({
    required this.user,
  });
  final User user;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
