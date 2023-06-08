// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_wrapper.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseWrapper _$ResponseWrapperFromJson(Map<String, dynamic> json) =>
    ResponseWrapper(
      response: json['response'] as Object,
      statusCode:
          $enumDecodeNullable(_$StatusCodesEnumMap, json['statusCode']) ??
              StatusCodes.unknown,
    );

Map<String, dynamic> _$ResponseWrapperToJson(ResponseWrapper instance) =>
    <String, dynamic>{
      'response': instance.response,
      'statusCode': _$StatusCodesEnumMap[instance.statusCode]!,
    };

const _$StatusCodesEnumMap = {
  StatusCodes.clientException: 'clientException',
  StatusCodes.formatException: 'formatException',
  StatusCodes.networkError: 'networkError',
  StatusCodes.unknown: 'unknown',
  StatusCodes.ok: 200,
  StatusCodes.created: 201,
  StatusCodes.badRequest: 400,
  StatusCodes.unauthorized: 401,
  StatusCodes.fordbidden: 403,
  StatusCodes.notFound: 404,
  StatusCodes.internalServerError: 500,
  StatusCodes.tooManyRequests: 429,
  StatusCodes.iforgotError: 452,
};
