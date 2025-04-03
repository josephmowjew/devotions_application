// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
  emailAddress: json['emailAddress'] as String?,
  employeeId: json['employeeId'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  enabled: json['enabled'] as bool?,
  disabledDate: json['disabledDate'],
  isLocked: json['is_locked'],
  deletedAt: json['deletedAt'],
  config:
      json['config'] == null
          ? null
          : Config.fromJson(json['config'] as Map<String, dynamic>),
  rolemaps:
      (json['rolemaps'] as List<dynamic>?)
          ?.map((e) => Rolemap.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'emailAddress': instance.emailAddress,
      'employeeId': instance.employeeId,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'enabled': instance.enabled,
      'disabledDate': instance.disabledDate,
      'is_locked': instance.isLocked,
      'deletedAt': instance.deletedAt,
      'config': instance.config,
      'rolemaps': instance.rolemaps,
    };
