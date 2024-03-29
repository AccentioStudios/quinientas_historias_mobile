import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_entity.g.dart';

@JsonSerializable()
class Author {
  Author({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.description,
    this.link,
    this.slug,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  final int id;
  final String name;
  final String? description;
  final String? link;
  final String? slug;
  final String avatarUrl;

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
