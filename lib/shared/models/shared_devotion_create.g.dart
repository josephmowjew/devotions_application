// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_devotion_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedDevotionCreate _$SharedDevotionCreateFromJson(
  Map<String, dynamic> json,
) => SharedDevotionCreate(
  devotionId: (json['devotionId'] as num?)?.toInt(),
  expireDate: json['expireDate'] as String?,
  expireDefault: (json['expireDefault'] as num?)?.toInt(),
  link: json['link'] as String?,
  recipientEmail: json['recipientEmail'] as String?,
  recipientNumber: json['recipientNumber'] as String?,
  shareType: json['shareType'] as String?,
  userId: json['userId'] as String?,
);

Map<String, dynamic> _$SharedDevotionCreateToJson(
  SharedDevotionCreate instance,
) => <String, dynamic>{
  'devotionId': instance.devotionId,
  'expireDate': instance.expireDate,
  'expireDefault': instance.expireDefault,
  'link': instance.link,
  'recipientEmail': instance.recipientEmail,
  'recipientNumber': instance.recipientNumber,
  'shareType': instance.shareType,
  'userId': instance.userId,
};
