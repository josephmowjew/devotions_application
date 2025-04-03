// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginError _$LoginErrorFromJson(Map<String, dynamic> json) => LoginError(
      status: json['status'] as String,
      message: json['message'] as String,
      attemptsRemaining: json['attempts_remaining'] as String,
    );

Map<String, dynamic> _$LoginErrorToJson(LoginError instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'attempts_remaining': instance.attemptsRemaining,
    };
