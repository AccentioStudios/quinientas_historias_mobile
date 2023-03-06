import 'dart:convert';

class SetStoryProgressRequest {
  SetStoryProgressRequest({
    required this.storyId,
    required this.progress,
    this.teamId,
  });

  final int storyId;
  final int progress;
  final int? teamId;

  SetStoryProgressRequest copyWith({
    int? storyId,
    int? progress,
    int? teamId,
  }) {
    return SetStoryProgressRequest(
      storyId: storyId ?? this.storyId,
      progress: progress ?? this.progress,
      teamId: teamId ?? this.teamId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storyId': storyId,
      'progress': progress,
      'teamId': teamId,
    };
  }

  factory SetStoryProgressRequest.fromMap(Map<String, dynamic> map) {
    return SetStoryProgressRequest(
      storyId: map['storyId'] as int,
      progress: map['progress'] as int,
      teamId: map['teamId'] != null ? map['teamId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SetStoryProgressRequest.fromJson(String source) =>
      SetStoryProgressRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SetStoryProgressRequest(storyId: $storyId, progress: $progress, teamId: $teamId)';

  @override
  bool operator ==(covariant SetStoryProgressRequest other) {
    if (identical(this, other)) return true;

    return other.storyId == storyId &&
        other.progress == progress &&
        other.teamId == teamId;
  }

  @override
  int get hashCode => storyId.hashCode ^ progress.hashCode ^ teamId.hashCode;
}
