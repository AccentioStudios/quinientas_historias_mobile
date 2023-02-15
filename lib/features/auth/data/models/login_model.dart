import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/user_2_entity.dart';

part 'login_model.g.dart';

@JsonSerializable()
class AuthRequest {
  AuthRequest({
    required this.user,
    this.firebaseToken,
  });

  final User2 user;
  final String? firebaseToken;

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
