import 'package:freezed_annotation/freezed_annotation.dart';
import 'user_entity.dart';

part 'story_entity.g.dart';

@JsonSerializable()
class Story {
  Story({
    required this.id,
    required this.title,
    this.author,
    this.coverUrl,
    this.coverColor,
    this.content,
    this.favorited,
    this.readingTime,
  });

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
  final int id;
  final String title;
  final User? author;
  final String? coverUrl;
  final String? coverColor;
  final String? content;
  final bool? favorited;
  final ReadTimeResults? readingTime;
  Map<String, dynamic> toJson() => _$StoryToJson(this);

  Story copyWith({
    int? id,
    String? title,
    User? author,
    String? coverUrl,
    String? coverColor,
    String? content,
    bool? favorited,
    ReadTimeResults? readingTime,
  }) {
    return Story(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      coverUrl: coverUrl ?? this.coverUrl,
      coverColor: coverColor ?? this.coverColor,
      content: content ?? this.content,
      favorited: favorited ?? this.favorited,
      readingTime: readingTime ?? this.readingTime,
    );
  }
}

@JsonSerializable()
class ReadTimeResults {
  ReadTimeResults({
    this.text,
    required this.minutes,
  });

  final String? text;
  @Default(0)
  final double minutes;
  factory ReadTimeResults.fromJson(Map<String, dynamic> json) =>
      _$ReadTimeResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ReadTimeResultsToJson(this);
}
