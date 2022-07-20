import 'dart:convert';

class VerifyOtpCodeRequest {
  VerifyOtpCodeRequest({
    required this.token,
    required this.code,
  });

  final String token;
  final String code;

  VerifyOtpCodeRequest copyWith({
    String? token,
    String? code,
  }) {
    return VerifyOtpCodeRequest(
      token: token ?? this.token,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'code': code,
    };
  }

  factory VerifyOtpCodeRequest.fromMap(Map<String, dynamic> map) {
    return VerifyOtpCodeRequest(
      token: map['token'] ?? '',
      code: map['code'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory VerifyOtpCodeRequest.fromJson(String source) =>
      VerifyOtpCodeRequest.fromMap(json.decode(source));

  @override
  String toString() => 'VerifyOtpCodeRequest(token: $token, code: $code)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VerifyOtpCodeRequest &&
        other.token == token &&
        other.code == code;
  }

  @override
  int get hashCode => token.hashCode ^ code.hashCode;
}
