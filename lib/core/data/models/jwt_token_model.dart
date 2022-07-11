import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class JWTTokenModel {
  JWTTokenModel({
    this.accessToken,
    this.userId,
    this.firstName,
    this.lastName,
    this.schoolId,
    this.teamId,
    this.type,
  });

  final String? accessToken;

  final int? userId;
  final String? firstName;
  final String? lastName;
  final int? schoolId;
  final int? teamId;
  final String? type;

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'schoolId': schoolId,
      'teamId': teamId,
      'type': type,
    };
  }

  factory JWTTokenModel.decode(Map<String, dynamic> map) {
    try {
      String jwtSignKey = dotenv.get('JWT_SIGN_KEY');

      String accessToken = map['accessToken'].toString();
      final jwt = JWT.verify(accessToken, SecretKey(jwtSignKey));
      final jwtData = jwt.payload['data'];

      return JWTTokenModel(
        accessToken: accessToken,
        userId: jwtData['userId']?.toInt(),
        firstName: jwtData['firstName'],
        lastName: jwtData['lastName'],
        schoolId: jwtData['schoolId']?.toInt(),
        teamId: jwtData['teamId']?.toInt(),
        type: jwtData['type'],
      );
    } catch (error) {
      rethrow;
    }
  }

  factory JWTTokenModel.fromMap(Map<String, dynamic> map) {
    return JWTTokenModel(
      accessToken: map['accessToken'],
      userId: map['userId']?.toInt(),
      firstName: map['firstName'],
      lastName: map['lastName'],
      schoolId: map['schoolId']?.toInt(),
      teamId: map['teamId']?.toInt(),
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory JWTTokenModel.fromJson(String source) =>
      JWTTokenModel.fromMap(json.decode(source));
}
