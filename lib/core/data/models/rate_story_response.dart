import 'dart:convert';

class RateStoryResponse {
  RateStoryResponse({
    required this.saved,
    this.errorMessage,
  });

  final bool saved;
  final String? errorMessage;

  factory RateStoryResponse.fromMap(Map<String, dynamic> map) {
    return RateStoryResponse(
      saved: map['saved'] ?? false,
      errorMessage: map['errorMessage'],
    );
  }

  factory RateStoryResponse.fromJson(String source) =>
      RateStoryResponse.fromMap(json.decode(source));
}
