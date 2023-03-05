// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

import 'author_entity.dart';

part 'story_entity.g.dart';

@JsonSerializable()
class Story {
  Story({
    required this.id,
    required this.title,
    this.author,
    this.slug,
    this.link,
    this.coverUrl,
    this.coverColor,
    this.content,
    this.favorited,
    this.readingTime,
  });

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
  final int id;
  final String title;
  final Author? author;
  final String? slug;
  final String? link;

  final String? coverUrl;
  final String? coverColor;
  final String? content;
  final bool? favorited;
  final ReadTimeResults? readingTime;
  Map<String, dynamic> toJson() => _$StoryToJson(this);

  Story copyWith({
    int? id,
    String? title,
    Author? author,
    String? slug,
    String? link,
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
      slug: slug ?? this.slug,
      link: link ?? this.link,
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
