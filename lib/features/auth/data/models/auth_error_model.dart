import 'dart:convert';

class AuthErrorModel {
  AuthErrorModel({
    this.emailErrorMessage,
    this.passwordErrorMessage,
    this.unknownErrorMessage,
  });

  final String? emailErrorMessage;
  final String? passwordErrorMessage;
  final String? unknownErrorMessage;

  Map<String, dynamic> toMap() {
    return {
      'emailErrorMessage': emailErrorMessage,
      'passwordErrorMessage': passwordErrorMessage,
      'unknownErrorMessage': unknownErrorMessage,
    };
  }

  factory AuthErrorModel.fromMap(Map<String, dynamic> map) {
    return AuthErrorModel(
      emailErrorMessage: map['emailErrorMessage'],
      passwordErrorMessage: map['passwordErrorMessage'],
      unknownErrorMessage: map['unknownErrorMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthErrorModel.fromJson(String source) =>
      AuthErrorModel.fromMap(json.decode(source));
}
