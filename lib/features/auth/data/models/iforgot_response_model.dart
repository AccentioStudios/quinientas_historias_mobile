import 'dart:convert';

class IForgotResponse {
  IForgotResponse({
    required this.token,
  });
  final String token;

  IForgotResponse copyWith({
    String? token,
  }) {
    return IForgotResponse(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }

  factory IForgotResponse.fromMap(Map<String, dynamic> map) {
    return IForgotResponse(
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory IForgotResponse.fromJson(String source) =>
      IForgotResponse.fromMap(json.decode(source));

  @override
  String toString() => 'IForgotResponse(token: $token)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is IForgotResponse && other.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}
