import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_model.g.dart';

@JsonSerializable()
class AuthRequest {
  AuthRequest({
    required this.credentials,
    this.firebaseToken,
  });

  final Map<String, dynamic> credentials;
  final String? firebaseToken;

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
