// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_devotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledDevotion _$ScheduledDevotionFromJson(Map<String, dynamic> json) =>
    ScheduledDevotion(
      branchId: json['branchId'] as String?,
      createdAt: json['createdAt'] as String?,
      devotion:
          json['devotion'] == null
              ? null
              : Devotion.fromJson(json['devotion'] as Map<String, dynamic>),
      devotionId: (json['devotionId'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      organisationId: (json['organisationId'] as num?)?.toInt(),
      scheduledDate: json['scheduledDate'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$ScheduledDevotionToJson(ScheduledDevotion instance) =>
    <String, dynamic>{
      'branchId': instance.branchId,
      'createdAt': instance.createdAt,
      'devotion': instance.devotion?.toJson(),
      'devotionId': instance.devotionId,
      'id': instance.id,
      'organisationId': instance.organisationId,
      'scheduledDate': instance.scheduledDate,
      'updatedAt': instance.updatedAt,
    };
