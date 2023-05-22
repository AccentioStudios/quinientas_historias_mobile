// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SarHealthResponseDto {
  const SarHealthResponseDto({
    required this.auth,
    required this.retos,
  });
  final SarHealthResponseItemDto auth;
  final SarHealthResponseItemDto retos;

  SarHealthResponseDto copyWith({
    SarHealthResponseItemDto? auth,
    SarHealthResponseItemDto? retos,
  }) {
    return SarHealthResponseDto(
      auth: auth ?? this.auth,
      retos: retos ?? this.retos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'auth': auth.toMap(),
      'retos': retos.toMap(),
    };
  }

  factory SarHealthResponseDto.fromMap(Map<String, dynamic> map) {
    return SarHealthResponseDto(
      auth:
          SarHealthResponseItemDto.fromMap(map['auth'] as Map<String, dynamic>),
      retos: SarHealthResponseItemDto.fromMap(
          map['retos'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory SarHealthResponseDto.fromJson(String source) =>
      SarHealthResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SarHealthResponseDto(auth: $auth, retos: $retos)';

  @override
  bool operator ==(covariant SarHealthResponseDto other) {
    if (identical(this, other)) return true;

    return other.auth == auth && other.retos == retos;
  }

  @override
  int get hashCode => auth.hashCode ^ retos.hashCode;
}

class SarHealthResponseItemDto {
  const SarHealthResponseItemDto({
    required this.ok,
    this.error,
    this.message,
  });

  final bool ok;
  final String? error;
  final String? message;

  SarHealthResponseItemDto copyWith({
    bool? ok,
    String? error,
    String? message,
  }) {
    return SarHealthResponseItemDto(
      ok: ok ?? this.ok,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ok': ok,
      'error': error,
      'message': message,
    };
  }

  factory SarHealthResponseItemDto.fromMap(Map<String, dynamic> map) {
    return SarHealthResponseItemDto(
      ok: map['ok'] as bool,
      error: map['error'] != null ? map['error'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SarHealthResponseItemDto.fromJson(String source) =>
      SarHealthResponseItemDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'SarHealthResponseItemDto(ok: $ok, error: $error, message: $message)';

  @override
  bool operator ==(covariant SarHealthResponseItemDto other) {
    if (identical(this, other)) return true;

    return other.ok == ok && other.error == error && other.message == message;
  }

  @override
  int get hashCode => ok.hashCode ^ error.hashCode ^ message.hashCode;
}
