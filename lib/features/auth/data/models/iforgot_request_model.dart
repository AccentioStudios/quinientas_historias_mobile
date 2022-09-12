import 'dart:convert';

class IForgotRequest {
  IForgotRequest({
    this.email,
    this.code,
    this.token,
    this.password,
    this.passwordConfirmation,
  });

  final String? email;
  final String? code;
  final String? token;
  final String? password;
  final String? passwordConfirmation;

  IForgotRequest copyWith({
    String? email,
    String? code,
    String? token,
    String? password,
    String? passwordConfirmation,
  }) {
    return IForgotRequest(
      email: email ?? this.email,
      code: code ?? this.code,
      token: token ?? this.token,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'code': code,
      'token': token,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
    };
  }

  factory IForgotRequest.fromMap(Map<String, dynamic> map) {
    return IForgotRequest(
      email: map['email'],
      code: map['code'],
      token: map['token'],
      password: map['password'],
      passwordConfirmation: map['passwordConfirmation'],
    );
  }

  String toJson() => json.encode(toMap());

  factory IForgotRequest.fromJson(String source) =>
      IForgotRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'IForgotRequest(email: $email, code: $code, token: $token, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IForgotRequest &&
        other.email == email &&
        other.code == code &&
        other.token == token &&
        other.password == password &&
        other.passwordConfirmation == passwordConfirmation;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        code.hashCode ^
        token.hashCode ^
        password.hashCode ^
        passwordConfirmation.hashCode;
  }
}
