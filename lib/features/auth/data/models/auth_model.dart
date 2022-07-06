import 'dart:convert';

class AuthModel {
  AuthModel({
    this.accessToken,
    this.userId,
    this.hasToUpdatePassword,
  });

  final String? accessToken;
  final String? userId;
  final bool? hasToUpdatePassword;

  AuthModel copyWith({
    String? accessToken,
    String? userId,
    bool? hasToUpdatePassword,
  }) {
    return AuthModel(
      accessToken: accessToken ?? this.accessToken,
      userId: userId ?? this.userId,
      hasToUpdatePassword: hasToUpdatePassword ?? this.hasToUpdatePassword,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'userId': userId,
      'hasToUpdatePassword': hasToUpdatePassword,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      accessToken: map['accessToken'],
      userId: map['userId'],
      hasToUpdatePassword: map['hasToUpdatePassword'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'AuthModel(accessToken: $accessToken, userId: $userId, hasToUpdatePassword: $hasToUpdatePassword)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthModel &&
        other.accessToken == accessToken &&
        other.userId == userId &&
        other.hasToUpdatePassword == hasToUpdatePassword;
  }

  @override
  int get hashCode =>
      accessToken.hashCode ^ userId.hashCode ^ hasToUpdatePassword.hashCode;
}
