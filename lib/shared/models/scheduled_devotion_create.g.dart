// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheduled_devotion_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScheduledDevotionCreate _$ScheduledDevotionCreateFromJson(
  Map<String, dynamic> json,
) => ScheduledDevotionCreate(
  devotionId: (json['devotionId'] as num?)?.toInt(),
  scheduledDate: json['scheduledDate'] as String?,
);

Map<String, dynamic> _$ScheduledDevotionCreateToJson(
  ScheduledDevotionCreate instance,
) => <String, dynamic>{
  'devotionId': instance.devotionId,
  'scheduledDate': instance.scheduledDate,
};
