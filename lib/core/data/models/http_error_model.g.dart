// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_error_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpErrorModel _$HttpErrorModelFromJson(Map<String, dynamic> json) =>
    HttpErrorModel(
      message: json['message'] as String?,
      errorCode: $enumDecodeNullable(_$ErrorCodesEnumMap, json['errorCode']) ??
          ErrorCodes.unknown,
    );

Map<String, dynamic> _$HttpErrorModelToJson(HttpErrorModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'errorCode': _$ErrorCodesEnumMap[instance.errorCode],
    };

const _$ErrorCodesEnumMap = {
  ErrorCodes.unknown: 'unknown',
  ErrorCodes.badRequest: '400',
  ErrorCodes.notFound: '404',
};
