import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/tournament_entity.dart';

import '../../../../core/data/entities/daily_challenge_entity.dart';
import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/data/entities/user_entity.dart';

part 'dashboard_entity.g.dart';

const List<Story> initialExploreStories = [];

@JsonSerializable()
class Dashboard {
  Dashboard(
      {required this.user,
      this.dailyChallenge,
      this.exploreStories = initialExploreStories,
      this.teamRank,
      this.schoolRank,
      this.tournament});
  final User user;
  final DailyChallenge? dailyChallenge;
  final List<Story> exploreStories;
  final int? teamRank;
  final int? schoolRank;
  final Tournament? tournament;

  factory Dashboard.fromJson(Map<String, dynamic> json) =>
      _$DashboardFromJson(json);
  Map<String, dynamic> toJson() => _$DashboardToJson(this);

  Dashboard copyWith({
    User? user,
    DailyChallenge? dailyChallenge,
    List<Story>? exploreStories,
    int? teamRank,
    int? schoolRank,
    Tournament? tournament,
  }) {
    return Dashboard(
      user: user ?? this.user,
      dailyChallenge: dailyChallenge ?? this.dailyChallenge,
      exploreStories: exploreStories ?? this.exploreStories,
      teamRank: teamRank ?? this.teamRank,
      schoolRank: schoolRank ?? this.schoolRank,
      tournament: tournament ?? this.tournament,
    );
  }
}
