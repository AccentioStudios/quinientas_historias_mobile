// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_failure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonFailure _$CommonFailureFromJson(Map<String, dynamic> json) =>
    CommonFailure(
      message: json['message'] as String?,
      error: $enumDecodeNullable(_$CommonFailureTypeEnumMap, json['error']) ??
          CommonFailureType.unknown,
    );

Map<String, dynamic> _$CommonFailureToJson(CommonFailure instance) =>
    <String, dynamic>{
      'message': instance.message,
      'error': _$CommonFailureTypeEnumMap[instance.error],
    };

const _$CommonFailureTypeEnumMap = {
  CommonFailureType.unknown: 'unknown',
};
