// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_devotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedDevotion _$SharedDevotionFromJson(Map<String, dynamic> json) =>
    SharedDevotion(
      branchId: json['branchId'] as String?,
      createdAt: json['createdAt'] as String?,
      devotion:
          json['devotion'] == null
              ? null
              : Devotion.fromJson(json['devotion'] as Map<String, dynamic>),
      devotionId: (json['devotionId'] as num?)?.toInt(),
      expireDate: json['expireDate'] as String?,
      expireDefault: (json['expireDefault'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      link: json['link'] as String?,
      organisationId: (json['organisationId'] as num?)?.toInt(),
      recipientEmail: json['recipientEmail'] as String?,
      recipientNumber: json['recipientNumber'] as String?,
      shareType: json['shareType'] as String?,
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$SharedDevotionToJson(SharedDevotion instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'createdAt': instance.createdAt,
      'devotion': instance.devotion?.toJson(),
      'devotionId': instance.devotionId,
      'expireDate': instance.expireDate,
      'expireDefault': instance.expireDefault,
      'id': instance.id,
      'link': instance.link,
      'organisationId': instance.organisationId,
      'recipientEmail': instance.recipientEmail,
      'recipientNumber': instance.recipientNumber,
      'shareType': instance.shareType,
      'userId': instance.userId,
    };
