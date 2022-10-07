import 'dart:convert';

class RegisterUserRequest {
  RegisterUserRequest({
    required this.email,
    this.password,
    this.passwordConfirmation,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.invitationCode,
  });

  final String email;
  final String? password;
  final String? passwordConfirmation;
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;
  final String? invitationCode;

  RegisterUserRequest copyWith({
    String? email,
    String? password,
    String? passwordConfirmation,
    String? firstName,
    String? lastName,
    String? avatarUrl,
    String? invitationCode,
  }) {
    return RegisterUserRequest(
      email: email ?? this.email,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      invitationCode: invitationCode ?? this.invitationCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
      'firstName': firstName,
      'lastName': lastName,
      'avatarUrl': avatarUrl,
      'invitationCode': invitationCode,
    };
  }

  factory RegisterUserRequest.fromMap(Map<String, dynamic> map) {
    return RegisterUserRequest(
      email: map['email'] ?? '',
      password: map['password'],
      passwordConfirmation: map['passwordConfirmation'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      avatarUrl: map['avatarUrl'],
      invitationCode: map['invitationCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterUserRequest.fromJson(String source) =>
      RegisterUserRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RegisterUserRequest(email: $email, password: $password, passwordConfirmation: $passwordConfirmation, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, invitationCode: $invitationCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegisterUserRequest &&
        other.email == email &&
        other.password == password &&
        other.passwordConfirmation == passwordConfirmation &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.avatarUrl == avatarUrl &&
        other.invitationCode == invitationCode;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        password.hashCode ^
        passwordConfirmation.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        avatarUrl.hashCode ^
        invitationCode.hashCode;
  }
}
