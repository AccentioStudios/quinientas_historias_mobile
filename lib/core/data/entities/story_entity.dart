import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../features/reading_module/data/models/author_model.dart';
part 'story_entity.g.dart';

@JsonSerializable()
class Story {
  Story(
      {required this.id,
      required this.title,
      this.readingTime,
      this.content,
      this.author,
      this.coverUrl,
      this.coverColor});

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
  final String id;
  final String title;
  final String? readingTime;
  final String? content;
  final Author? author;
  final String? coverUrl;
  final String? coverColor;
  Map<String, dynamic> toJson() => _$StoryToJson(this);
}
