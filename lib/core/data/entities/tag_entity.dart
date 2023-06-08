import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag_entity.g.dart';

@JsonSerializable()
class Tag {
  const Tag(this.count, this.name, this.slug, this.taxonomy,
      {required this.id});

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);
  final int id;
  final int? count;
  final String name;
  final String slug;
  final String? taxonomy;

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
