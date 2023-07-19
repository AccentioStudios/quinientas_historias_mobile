// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LikeDislikeQuizItemDto {
  LikeDislikeQuizItemDto({required this.liked});

  final bool liked;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'liked': liked,
    };
  }

  factory LikeDislikeQuizItemDto.fromMap(Map<String, dynamic> map) {
    return LikeDislikeQuizItemDto(
      liked: map['liked'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory LikeDislikeQuizItemDto.fromJson(String source) =>
      LikeDislikeQuizItemDto.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
