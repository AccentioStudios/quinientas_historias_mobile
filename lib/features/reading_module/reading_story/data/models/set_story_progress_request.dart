// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UpdateStoryProgressDto {
  UpdateStoryProgressDto({
    required this.storyId,
    this.tags,
    required this.progress,
    this.teamId,
  });

  final int storyId;
  final List<int>? tags;
  final int progress;
  final int? teamId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storyId': storyId,
      'tags': tags,
      'progress': progress,
      'teamId': teamId,
    };
  }

  factory UpdateStoryProgressDto.fromMap(Map<String, dynamic> map) {
    return UpdateStoryProgressDto(
      storyId: map['storyId'] as int,
      tags: map['tags'] != null
          ? List<int>.from((map['tags'] as List<int>))
          : null,
      progress: map['progress'] as int,
      teamId: map['teamId'] != null ? map['teamId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UpdateStoryProgressDto.fromJson(String source) =>
      UpdateStoryProgressDto.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
