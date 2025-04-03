// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_exception.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiException _$ApiExceptionFromJson(Map<String, dynamic> json) => ApiException(
  eventTime:
      json['eventTime'] == null
          ? null
          : DateTime.parse(json['eventTime'] as String),
  error: json['error'] as String?,
  errorDescription: json['errorDescription'] as String?,
  errorCode: json['errorCode'] as String?,
);

Map<String, dynamic> _$ApiExceptionToJson(ApiException instance) =>
    <String, dynamic>{
      'eventTime': instance.eventTime?.toIso8601String(),
      'error': instance.error,
      'errorDescription': instance.errorDescription,
      'errorCode': instance.errorCode,
    };
