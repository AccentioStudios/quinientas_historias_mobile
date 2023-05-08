// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegisterNewChallengeResponseDto {
  RegisterNewChallengeResponseDto({
    required this.uuid,
    required this.secretKey,
  });
  final String uuid;
  final String secretKey;

  RegisterNewChallengeResponseDto copyWith({
    String? uuid,
    String? secretKey,
  }) {
    return RegisterNewChallengeResponseDto(
      uuid: uuid ?? this.uuid,
      secretKey: secretKey ?? this.secretKey,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'secretKey': secretKey,
    };
  }

  factory RegisterNewChallengeResponseDto.fromMap(Map<String, dynamic> map) {
    return RegisterNewChallengeResponseDto(
      uuid: map['uuid'] as String,
      secretKey: map['secretKey'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterNewChallengeResponseDto.fromJson(String source) =>
      RegisterNewChallengeResponseDto.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'RegisterNewChallengeResponseDto(uuid: $uuid, secretKey: $secretKey)';

  @override
  bool operator ==(covariant RegisterNewChallengeResponseDto other) {
    if (identical(this, other)) return true;

    return other.uuid == uuid && other.secretKey == secretKey;
  }

  @override
  int get hashCode => uuid.hashCode ^ secretKey.hashCode;
}
