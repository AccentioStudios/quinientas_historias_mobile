import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/daily_challenge_entity.dart';
import '../../../../core/data/entities/user_entity.dart';

part 'dashboard_entity.g.dart';

@JsonSerializable()
class Dashboard {
  Dashboard({required this.user, this.dailyChallenge});
  final User user;
  final DailyChallenge? dailyChallenge;

  factory Dashboard.fromJson(Map<String, dynamic> json) =>
      _$DashboardFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardToJson(this);
}
