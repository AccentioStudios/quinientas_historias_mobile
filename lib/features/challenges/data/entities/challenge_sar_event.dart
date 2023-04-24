import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_sar_event.g.dart';

@JsonSerializable()
class ChallengeSarEvent {
  ChallengeSarEvent({
    required this.trigger,
    required this.userId,
    this.storyId,
    required this.now,
  });

  final ChallengeSarTriggers trigger;
  final int userId;
  final int? storyId;
  final DateTime now;

  factory ChallengeSarEvent.fromJson(Map<String, dynamic> json) =>
      _$ChallengeSarEventFromJson(json);

  Map<String, dynamic> toJson() => _$ChallengeSarEventToJson(this);
}

enum ChallengeSarTriggers {
  @JsonValue('story-ended')
  storyEnded,
  @JsonValue('story-init')
  storyInit,
  @JsonValue('first-session-of-day')
  firstSessionOfDay
}
