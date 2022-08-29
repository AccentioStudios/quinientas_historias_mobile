import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/user_entity.dart';

part 'invites_response_model.g.dart';

@JsonSerializable()
class InvitesResponse {
  InvitesResponse({
    required this.email,
    required this.type,
  });
  final String email;
  final UserType type;

  factory InvitesResponse.fromJson(Map<String, dynamic> json) =>
      _$InvitesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InvitesResponseToJson(this);
}
