// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_failure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommonFailure _$CommonFailureFromJson(Map<String, dynamic> json) =>
    CommonFailure(
      message: json['message'] as String?,
      errorType:
          $enumDecodeNullable(_$CommonFailureTypeEnumMap, json['errorType']) ??
              CommonFailureType.unknown,
    );

Map<String, dynamic> _$CommonFailureToJson(CommonFailure instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errorType': _$CommonFailureTypeEnumMap[instance.errorType],
    };

const _$CommonFailureTypeEnumMap = {
  CommonFailureType.unknown: 'unknown',
};
