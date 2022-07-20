import 'dart:convert';

class IForgotRequest {
  IForgotRequest({
    this.email,
    this.code,
    this.token,
    this.newPassword,
  });

  final String? email;
  final String? code;
  final String? token;
  final String? newPassword;

  IForgotRequest copyWith({
    String? email,
    String? code,
    String? token,
    String? newPassword,
  }) {
    return IForgotRequest(
      email: email ?? this.email,
      code: code ?? this.code,
      token: token ?? this.token,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'code': code,
      'token': token,
      'newPassword': newPassword,
    };
  }

  factory IForgotRequest.fromMap(Map<String, dynamic> map) {
    return IForgotRequest(
      email: map['email'],
      code: map['code'],
      token: map['token'],
      newPassword: map['newPassword'],
    );
  }

  String toJson() => json.encode(toMap());

  factory IForgotRequest.fromJson(String source) =>
      IForgotRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'IForgotRequest(email: $email, code: $code, token: $token, newPassword: $newPassword)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IForgotRequest &&
        other.email == email &&
        other.code == code &&
        other.token == token &&
        other.newPassword == newPassword;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        code.hashCode ^
        token.hashCode ^
        newPassword.hashCode;
  }
}
