// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_locked_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountLockedDto _$AccountLockedDtoFromJson(Map<String, dynamic> json) =>
    AccountLockedDto(
      status: json['status'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$AccountLockedDtoToJson(AccountLockedDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
