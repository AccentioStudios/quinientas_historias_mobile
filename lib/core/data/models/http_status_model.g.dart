// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpStatusModel _$HttpStatusModelFromJson(Map<String, dynamic> json) =>
    HttpStatusModel(
      message: json['message'] as String?,
      statusCode:
          $enumDecodeNullable(_$StatusCodesEnumMap, json['statusCode']) ??
              StatusCodes.unknown,
    );

Map<String, dynamic> _$HttpStatusModelToJson(HttpStatusModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'statusCode': _$StatusCodesEnumMap[instance.statusCode],
    };

const _$StatusCodesEnumMap = {
  StatusCodes.unknown: 'unknown',
  StatusCodes.ok: '200',
  StatusCodes.badRequest: '400',
  StatusCodes.unauthorized: '401',
  StatusCodes.fordbidden: '403',
  StatusCodes.notFound: '404',
  StatusCodes.internalServerError: '500',
};
