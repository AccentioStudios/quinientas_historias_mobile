import 'dart:convert';

class RateStoryRequest {
  RateStoryRequest({
    required this.niceRating,
    this.qualityRating,
    this.veracityRating,
    this.originalityRating,
    this.educationalRating,
  });
  final int? niceRating;
  final int? qualityRating;
  final int? veracityRating;
  final int? originalityRating;
  final int? educationalRating;

  RateStoryRequest copyWith({
    int? niceRating,
    int? qualityRating,
    int? veracityRating,
    int? originalityRating,
    int? educationalRating,
  }) {
    return RateStoryRequest(
      niceRating: niceRating ?? this.niceRating,
      qualityRating: qualityRating ?? this.qualityRating,
      veracityRating: veracityRating ?? this.veracityRating,
      originalityRating: originalityRating ?? this.originalityRating,
      educationalRating: educationalRating ?? this.educationalRating,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'niceRating': niceRating,
      'qualityRating': qualityRating,
      'veracityRating': veracityRating,
      'originalityRating': originalityRating,
      'educationalRating': educationalRating,
    };
  }

  factory RateStoryRequest.fromMap(Map<String, dynamic> map) {
    return RateStoryRequest(
      niceRating: map['niceRating']?.toInt() ?? 0,
      qualityRating: map['qualityRating']?.toInt(),
      veracityRating: map['veracityRating']?.toInt(),
      originalityRating: map['originalityRating']?.toInt(),
      educationalRating: map['educationalRating']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory RateStoryRequest.fromJson(String source) =>
      RateStoryRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RateStoryRequest(niceRating: $niceRating, qualityRating: $qualityRating, veracityRating: $veracityRating, originalityRating: $originalityRating, educationalRating: $educationalRating)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RateStoryRequest &&
        other.niceRating == niceRating &&
        other.qualityRating == qualityRating &&
        other.veracityRating == veracityRating &&
        other.originalityRating == originalityRating &&
        other.educationalRating == educationalRating;
  }

  @override
  int get hashCode {
    return niceRating.hashCode ^
        qualityRating.hashCode ^
        veracityRating.hashCode ^
        originalityRating.hashCode ^
        educationalRating.hashCode;
  }
}
