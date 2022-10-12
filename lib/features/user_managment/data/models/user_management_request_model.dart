import 'dart:convert';

class UserManagementRequest {
  UserManagementRequest({
    required this.email,
    this.id,
    this.password,
    this.passwordConfirmation,
    this.firstName,
    this.lastName,
    this.avatarUrl,
    this.invitationCode,
  });

  final String email;
  final int? id;
  final String? password;
  final String? passwordConfirmation;
  final String? firstName;
  final String? lastName;
  final String? avatarUrl;
  final String? invitationCode;

  UserManagementRequest copyWith({
    String? email,
    int? id,
    String? password,
    String? passwordConfirmation,
    String? firstName,
    String? lastName,
    String? avatarUrl,
    String? invitationCode,
  }) {
    return UserManagementRequest(
      email: email ?? this.email,
      id: id ?? this.id,
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
      'id': id,
      'password': password,
      'passwordConfirmation': passwordConfirmation,
      'firstName': firstName,
      'lastName': lastName,
      'avatarUrl': avatarUrl,
      'invitationCode': invitationCode,
    };
  }

  factory UserManagementRequest.fromMap(Map<String, dynamic> map) {
    return UserManagementRequest(
      email: map['email'] ?? '',
      id: map['id']?.toInt(),
      password: map['password'],
      passwordConfirmation: map['passwordConfirmation'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      avatarUrl: map['avatarUrl'],
      invitationCode: map['invitationCode'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserManagementRequest.fromJson(String source) =>
      UserManagementRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserManagementRequest(email: $email, id: $id, password: $password, passwordConfirmation: $passwordConfirmation, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, invitationCode: $invitationCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserManagementRequest &&
        other.email == email &&
        other.id == id &&
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
        id.hashCode ^
        password.hashCode ^
        passwordConfirmation.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        avatarUrl.hashCode ^
        invitationCode.hashCode;
  }
}
