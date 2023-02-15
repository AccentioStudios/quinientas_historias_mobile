import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_2_entity.g.dart';

@JsonSerializable()
class User2 {
  User2({
    this.id,
    this.name,
    this.givenName,
    this.familyName,
    this.middleName,
    this.nickname,
    this.avatarUrl,
    this.email,
  });

  factory User2.fromJson(Map<String, dynamic> json) => _$User2FromJson(json);

  final int? id;
  final String? name;
  final String? givenName;
  final String? familyName;
  final String? middleName;
  final String? nickname;
  final String? avatarUrl;
  final String? email;

  Map<String, dynamic> toJson() => _$User2ToJson(this);
}
