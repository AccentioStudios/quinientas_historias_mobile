import 'dart:convert';

class AuthRequest {
  AuthRequest({
    required this.email,
    required this.password,
    required this.firebaseToken,
  });

  final String email;
  final String password;
  final String firebaseToken;

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'firebaseToken': firebaseToken,
    };
  }

  factory AuthRequest.fromMap(Map<String, dynamic> map) {
    return AuthRequest(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      firebaseToken: map['firebaseToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthRequest.fromJson(String source) =>
      AuthRequest.fromMap(json.decode(source));
}
