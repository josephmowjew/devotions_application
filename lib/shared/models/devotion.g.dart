// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Devotion _$DevotionFromJson(Map<String, dynamic> json) => Devotion(
  branchId: json['branch_id'] as String?,
  createdAt: json['created_at'] as String?,
  createdBy: (json['created_by'] as num?)?.toInt(),
  devotion: json['devotion'] as String?,
  favorites:
      (json['favorites'] as List<dynamic>?)
          ?.map((e) => Favorite.fromJson(e as Map<String, dynamic>))
          .toList(),
  id: (json['id'] as num?)?.toInt(),
  organisationId: (json['organisation_id'] as num?)?.toInt(),
  prayer: json['prayer'] as String?,
  scheduledDevotions:
      (json['scheduled_devotions'] as List<dynamic>?)
          ?.map((e) => ScheduledDevotion.fromJson(e as Map<String, dynamic>))
          .toList(),
  scriptureReading: json['scripture_reading'] as String?,
  scriptureText: json['scripture_text'] as String?,
  sharedDevotions:
      (json['shared_devotions'] as List<dynamic>?)
          ?.map((e) => SharedDevotion.fromJson(e as Map<String, dynamic>))
          .toList(),
  title: json['title'] as String?,
  updatedAt: json['updated_at'] as String?,
  userNotes:
      (json['user_notes'] as List<dynamic>?)
          ?.map((e) => UserNote.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$DevotionToJson(Devotion instance) => <String, dynamic>{
  'branch_id': instance.branchId,
  'created_at': instance.createdAt,
  'created_by': instance.createdBy,
  'devotion': instance.devotion,
  'favorites': instance.favorites?.map((e) => e.toJson()).toList(),
  'id': instance.id,
  'organisation_id': instance.organisationId,
  'prayer': instance.prayer,
  'scheduled_devotions':
      instance.scheduledDevotions?.map((e) => e.toJson()).toList(),
  'scripture_reading': instance.scriptureReading,
  'scripture_text': instance.scriptureText,
  'shared_devotions': instance.sharedDevotions?.map((e) => e.toJson()).toList(),
  'title': instance.title,
  'updated_at': instance.updatedAt,
  'user_notes': instance.userNotes?.map((e) => e.toJson()).toList(),
};
