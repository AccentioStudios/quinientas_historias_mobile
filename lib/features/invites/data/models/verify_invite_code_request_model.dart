import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_invite_code_request_model.g.dart';

@JsonSerializable()
class VerifyInviteCodeRequest {
  VerifyInviteCodeRequest({
    required this.email,
    required this.code,
  });
  final String email;
  final String code;

  factory VerifyInviteCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyInviteCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyInviteCodeRequestToJson(this);
}
