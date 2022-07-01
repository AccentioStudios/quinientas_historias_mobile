import 'package:freezed_annotation/freezed_annotation.dart';

part 'author_model.g.dart';

@JsonSerializable()
class Author {
  Author({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory Author.fromJson(Map<String, dynamic> json) => _$AuthorFromJson(json);

  final String id;
  final String firstName;
  final String lastName;
  final String email;

  Map<String, dynamic> toJson() => _$AuthorToJson(this);
}
