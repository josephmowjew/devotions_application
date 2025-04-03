// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_devotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledDevotion _$ScheduledDevotionFromJson(Map<String, dynamic> json) =>
    ScheduledDevotion(
      branchId: json['branch_id'] as String?,
      createdAt: json['created_at'] as String?,
      devotion:
          json['devotion'] == null
              ? null
              : Devotion.fromJson(json['devotion'] as Map<String, dynamic>),
      devotionId: (json['devotion_id'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      organisationId: (json['organisation_id'] as num?)?.toInt(),
      scheduledDate: json['scheduled_date'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$ScheduledDevotionToJson(ScheduledDevotion instance) =>
    <String, dynamic>{
      'branch_id': instance.branchId,
      'created_at': instance.createdAt,
      'devotion': instance.devotion?.toJson(),
      'devotion_id': instance.devotionId,
      'id': instance.id,
      'organisation_id': instance.organisationId,
      'scheduled_date': instance.scheduledDate,
      'updated_at': instance.updatedAt,
    };
