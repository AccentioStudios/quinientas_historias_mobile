// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'failures.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Failure _$FailureFromJson(Map<String, dynamic> json) => Failure(
      message: json['message'] as String?,
      error: json['error'],
      statusCode: $enumDecodeNullable(_$StatusCodesEnumMap, json['statusCode']),
    );

Map<String, dynamic> _$FailureToJson(Failure instance) => <String, dynamic>{
      'message': instance.message,
      'error': instance.error,
      'statusCode': _$StatusCodesEnumMap[instance.statusCode],
    };

const _$StatusCodesEnumMap = {
  StatusCodes.networkError: 'networkError',
  StatusCodes.unknown: 'unknown',
  StatusCodes.ok: 200,
  StatusCodes.badRequest: 400,
  StatusCodes.unauthorized: 401,
  StatusCodes.fordbidden: 403,
  StatusCodes.notFound: 404,
  StatusCodes.internalServerError: 500,
  StatusCodes.mustUpdatePassword: 451,
  StatusCodes.iforgotError: 452,
};
