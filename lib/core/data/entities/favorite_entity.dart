import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quinientas_historias/core/data/entities/story_entity.dart';
import 'user_entity.dart';

part 'favorite_entity.g.dart';

@JsonSerializable()
class Favorite {
  Favorite({
    required this.id,
    required this.storyId,
    required this.userId,
    required this.story,
    this.user,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);

  final int id;
  final String storyId;
  final String userId;
  final User? user;
  final Story story;

  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}
