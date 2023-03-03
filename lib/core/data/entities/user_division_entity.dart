import 'package:freezed_annotation/freezed_annotation.dart';

import 'division_entity.dart';

part 'user_division_entity.g.dart';

@JsonSerializable()
class UserDivision {
  UserDivision({
    this.id,
    this.userId,
    this.divisionId,
    this.tournamentId,
    this.division,
  });

  factory UserDivision.fromJson(Map<String, dynamic> json) =>
      _$UserDivisionFromJson(json);

  final int? id;
  final int? userId;
  final int? divisionId;
  final int? tournamentId;
  final Division? division;

  Map<String, dynamic> toJson() => _$UserDivisionToJson(this);
}
