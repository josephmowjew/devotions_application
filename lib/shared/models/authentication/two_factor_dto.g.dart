// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'two_factor_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TwoFactorDto _$TwoFactorDtoFromJson(Map<String, dynamic> json) => TwoFactorDto(
  username: json['username'] as String,
  securityCode: json['securityCode'] as String,
);

Map<String, dynamic> _$TwoFactorDtoToJson(TwoFactorDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'securityCode': instance.securityCode,
    };
