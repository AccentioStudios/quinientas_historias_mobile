// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpResponse _$HttpResponseFromJson(Map<String, dynamic> json) => HttpResponse(
      body: json['body'] as String?,
      statusCode:
          $enumDecodeNullable(_$StatusCodesEnumMap, json['statusCode']) ??
              StatusCodes.unknown,
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      stackTrace: json['stackTrace'],
    );

Map<String, dynamic> _$HttpResponseToJson(HttpResponse instance) =>
    <String, dynamic>{
      'body': instance.body,
      'statusCode': _$StatusCodesEnumMap[instance.statusCode],
      'headers': instance.headers,
      'stackTrace': instance.stackTrace,
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
  StatusCodes.iforgotError: 452,
};
