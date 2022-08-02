import 'dart:convert';

class SaveFavoriteResponse {
  SaveFavoriteResponse({
    required this.favorited,
    this.errorMessage,
  });

  final bool favorited;
  final String? errorMessage;

  factory SaveFavoriteResponse.fromMap(Map<String, dynamic> map) {
    return SaveFavoriteResponse(
      favorited: map['favorited'] ?? false,
      errorMessage: map['errorMessage'],
    );
  }

  factory SaveFavoriteResponse.fromJson(String source) =>
      SaveFavoriteResponse.fromMap(json.decode(source));
}
