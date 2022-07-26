import 'dart:convert';

class SetStoryProgressResponse {
  SetStoryProgressResponse({
    required this.saved,
    this.errorMessage,
  });

  final bool saved;
  final String? errorMessage;

  SetStoryProgressResponse copyWith({
    bool? saved,
    String? errorMessage,
  }) {
    return SetStoryProgressResponse(
      saved: saved ?? this.saved,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'saved': saved,
      'errorMessage': errorMessage,
    };
  }

  factory SetStoryProgressResponse.fromMap(Map<String, dynamic> map) {
    return SetStoryProgressResponse(
      saved: map['saved'] ?? false,
      errorMessage: map['errorMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SetStoryProgressResponse.fromJson(String source) =>
      SetStoryProgressResponse.fromMap(json.decode(source));

  @override
  String toString() =>
      'SetStoryProgressResponse(saved: $saved, errorMessage: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SetStoryProgressResponse &&
        other.saved == saved &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => saved.hashCode ^ errorMessage.hashCode;
}
