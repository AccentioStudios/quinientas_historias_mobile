import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../core/data/entities/user_entity.dart';

part 'invites_request_model.g.dart';

@JsonSerializable()
class InvitesRequest {
  InvitesRequest({
    required this.email,
    required this.type,
    this.teamId,
    this.schoolId,
  });
  final String email;
  final Role type;
  final int? teamId;
  final int? schoolId;

  factory InvitesRequest.fromJson(Map<String, dynamic> json) =>
      _$InvitesRequestFromJson(json);

  Map<String, dynamic> toJson() => _$InvitesRequestToJson(this);
}
