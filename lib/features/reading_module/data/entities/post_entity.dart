import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/entities/author_entitiy.dart';
part 'post_entity.g.dart';

@JsonSerializable()
class Post {
  Post({
    required this.id,
    required this.title,
    this.content,
    this.author,
    this.coverUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  final String id;
  final String title;
  final String? content;
  final Author? author;
  final String? coverUrl;
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
