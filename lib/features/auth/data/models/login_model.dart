import 'dart:convert';

class AuthRequest {
  AuthRequest({
    required this.email,
    required this.password,
    this.firebaseToken,
  });

  final String email;
  final String password;
  final String? firebaseToken;

  AuthRequest copyWith({
    String? email,
    String? password,
    String? firebaseToken,
  }) {
    return AuthRequest(
      email: email ?? this.email,
      password: password ?? this.password,
      firebaseToken: firebaseToken ?? this.firebaseToken,
    );
  }

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
      firebaseToken: map['firebaseToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthRequest.fromJson(String source) =>
      AuthRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'AuthRequest(email: $email, password: $password, firebaseToken: $firebaseToken)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthRequest &&
        other.email == email &&
        other.password == password &&
        other.firebaseToken == firebaseToken;
  }

  @override
  int get hashCode =>
      email.hashCode ^ password.hashCode ^ firebaseToken.hashCode;
}
