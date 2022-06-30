// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'http_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpResponse _$HttpResponseFromJson(Map<String, dynamic> json) => HttpResponse(
      body: json['body'] as String?,
      jsonData: json['jsonData'] as Map<String, dynamic>?,
      status: json['status'] == null
          ? null
          : HttpStatusModel.fromJson(json['status'] as Map<String, dynamic>),
      headers: (json['headers'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      stackTrace: json['stackTrace'],
    );

Map<String, dynamic> _$HttpResponseToJson(HttpResponse instance) =>
    <String, dynamic>{
      'body': instance.body,
      'jsonData': instance.jsonData,
      'status': instance.status,
      'headers': instance.headers,
      'stackTrace': instance.stackTrace,
    };
