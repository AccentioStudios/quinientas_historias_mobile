import 'dart:convert';

class VerifyOtpCodeResponse {
  VerifyOtpCodeResponse({
    required this.isValid,
  });

  final bool isValid;

  VerifyOtpCodeResponse copyWith({
    bool? isValid,
  }) {
    return VerifyOtpCodeResponse(
      isValid: isValid ?? this.isValid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isValid': isValid,
    };
  }

  factory VerifyOtpCodeResponse.fromMap(Map<String, dynamic> map) {
    return VerifyOtpCodeResponse(
      isValid: map['isValid'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyOtpCodeResponse.fromJson(String source) =>
      VerifyOtpCodeResponse.fromMap(json.decode(source));

  @override
  String toString() => 'VerifyOtpCodeResponse(isValid: $isValid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VerifyOtpCodeResponse && other.isValid == isValid;
  }

  @override
  int get hashCode => isValid.hashCode;
}
