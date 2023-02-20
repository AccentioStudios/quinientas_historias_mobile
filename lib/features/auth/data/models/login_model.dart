import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable()
class AuthRequest {
  AuthRequest({
    required this.accessToken,
    this.firebaseToken,
  });

  final String accessToken;
  final String? firebaseToken;

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
