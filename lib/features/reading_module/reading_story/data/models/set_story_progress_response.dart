import 'dart:convert';

class SetStoryProgressResponse {
  SetStoryProgressResponse({
    required this.saved,
    this.points,
    this.errorMessage,
  });

  final bool saved;
  final int? points;
  final String? errorMessage;

  SetStoryProgressResponse copyWith({
    bool? saved,
    int? points,
    String? errorMessage,
  }) {
    return SetStoryProgressResponse(
      saved: saved ?? this.saved,
      points: points ?? this.points,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'saved': saved,
      'points': points,
      'errorMessage': errorMessage,
    };
  }

  factory SetStoryProgressResponse.fromMap(Map<String, dynamic> map) {
    return SetStoryProgressResponse(
      saved: map['saved'] ?? false,
      points: map['points']?.toInt(),
      errorMessage: map['errorMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SetStoryProgressResponse.fromJson(String source) =>
      SetStoryProgressResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'SetStoryProgressResponse(saved: $saved, points: $points, errorMessage: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SetStoryProgressResponse &&
        other.saved == saved &&
        other.points == points &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => saved.hashCode ^ points.hashCode ^ errorMessage.hashCode;
}
