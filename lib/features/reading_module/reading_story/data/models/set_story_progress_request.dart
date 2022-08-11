import 'dart:convert';

class SetStoryProgressRequest {
  SetStoryProgressRequest({
    required this.storyId,
    required this.progress,
  });

  final int storyId;
  final int progress;

  SetStoryProgressRequest copyWith({
    int? userId,
    int? storyId,
    int? progress,
  }) {
    return SetStoryProgressRequest(
      storyId: storyId ?? this.storyId,
      progress: progress ?? this.progress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'storyId': storyId,
      'progress': progress,
    };
  }

  factory SetStoryProgressRequest.fromMap(Map<String, dynamic> map) {
    return SetStoryProgressRequest(
      storyId: map['storyId']?.toInt() ?? 0,
      progress: map['progress']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory SetStoryProgressRequest.fromJson(String source) =>
      SetStoryProgressRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'SetProgressRequest( storyId: $storyId, progress: $progress)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SetStoryProgressRequest &&
        other.storyId == storyId &&
        other.progress == progress;
  }

  @override
  int get hashCode => storyId.hashCode ^ progress.hashCode;
}
