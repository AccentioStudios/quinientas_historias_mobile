import 'dart:convert';

class SaveFavoriteRequest {
  SaveFavoriteRequest({
    required this.storyId,
  });
  final int storyId;

  Map<String, dynamic> toMap() {
    return {
      'storyId': storyId,
    };
  }

  factory SaveFavoriteRequest.fromMap(Map<String, dynamic> map) {
    return SaveFavoriteRequest(
      storyId: map['storyId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());
}
