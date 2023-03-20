import 'package:freezed_annotation/freezed_annotation.dart';

import 'division_entity.dart';

part 'user_division_entity.g.dart';

@JsonSerializable()
class UserDivision {
  UserDivision({
    this.next,
    this.current,
  });

  factory UserDivision.fromJson(Map<String, dynamic> json) =>
      _$UserDivisionFromJson(json);

  final Division? next;
  final Division? current;

  Map<String, dynamic> toJson() => _$UserDivisionToJson(this);
}
