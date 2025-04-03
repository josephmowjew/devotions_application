// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_devotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedDevotion _$SharedDevotionFromJson(Map<String, dynamic> json) =>
    SharedDevotion(
      branchId: json['branch_id'] as String?,
      createdAt: json['created_at'] as String?,
      devotion:
          json['devotion'] == null
              ? null
              : Devotion.fromJson(json['devotion'] as Map<String, dynamic>),
      devotionId: (json['devotion_id'] as num?)?.toInt(),
      expireDate: json['expire_date'] as String?,
      expireDefault: (json['expire_default'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      link: json['link'] as String?,
      organisationId: (json['organisation_id'] as num?)?.toInt(),
      recipientEmail: json['recipient_email'] as String?,
      recipientNumber: json['recipient_number'] as String?,
      shareType: json['share_type'] as String?,
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$SharedDevotionToJson(SharedDevotion instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'created_at': instance.createdAt,
      'devotion': instance.devotion?.toJson(),
      'devotion_id': instance.devotionId,
      'expire_date': instance.expireDate,
      'expire_default': instance.expireDefault,
      'id': instance.id,
      'link': instance.link,
      'organisation_id': instance.organisationId,
      'recipient_email': instance.recipientEmail,
      'recipient_number': instance.recipientNumber,
      'share_type': instance.shareType,
      'user_id': instance.userId,
    };
