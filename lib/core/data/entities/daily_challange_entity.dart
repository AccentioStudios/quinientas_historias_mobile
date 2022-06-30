import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/story_entity.dart';

import '../../../../core/data/entities/school_entity.dart';
import '../../../../core/data/entities/team_entity.dart';
import 'story_progress_entity.dart';

part 'daily_challange_entity.g.dart';

@JsonSerializable()
class DailyChallange {
  DailyChallange({
    required this.count,
    required this.readed,
    required this.challange,
  });

  factory DailyChallange.fromJson(Map<String, dynamic> json) =>
      _$DailyChallangeFromJson(json);

  final int count;
  final int readed;
  final List<StoryProgress?> challange;

  Map<String, dynamic> toJson() => _$DailyChallangeToJson(this);
}
