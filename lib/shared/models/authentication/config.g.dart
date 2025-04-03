// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
  profileConfigId: (json['profileConfigId'] as num?)?.toInt(),
  twoFactorEnabled: json['twoFactorEnabled'] as bool?,
  emailAddress: json['emailAddress'] as String?,
  communicationMethod: json['communicationMethod'] as String?,
  twoFactorConfig: json['twoFactorConfig'],
);

Map<String, dynamic> _$ConfigToJson(Config instance) => <String, dynamic>{
  'profileConfigId': instance.profileConfigId,
  'twoFactorEnabled': instance.twoFactorEnabled,
  'emailAddress': instance.emailAddress,
  'communicationMethod': instance.communicationMethod,
  'twoFactorConfig': instance.twoFactorConfig,
};
