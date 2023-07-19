// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ApproveDisapproveQuizItemDto {
  ApproveDisapproveQuizItemDto({required this.approved});

  final bool approved;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'approved': approved,
    };
  }

  factory ApproveDisapproveQuizItemDto.fromMap(Map<String, dynamic> map) {
    return ApproveDisapproveQuizItemDto(
      approved: map['approved'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApproveDisapproveQuizItemDto.fromJson(String source) =>
      ApproveDisapproveQuizItemDto.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
