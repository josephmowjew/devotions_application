// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Devotion _$DevotionFromJson(Map<String, dynamic> json) => Devotion(
  branchId: json['branchId'] as String?,
  createdAt: json['createdAt'] as String?,
  createdBy: (json['createdBy'] as num?)?.toInt(),
  devotion: json['devotion'] as String?,
  favorites:
      (json['favorites'] as List<dynamic>?)
          ?.map((e) => Favorite.fromJson(e as Map<String, dynamic>))
          .toList(),
  id: (json['id'] as num?)?.toInt(),
  organisationId: (json['organisationId'] as num?)?.toInt(),
  prayer: json['prayer'] as String?,
  scheduledDevotions:
      (json['scheduledDevotions'] as List<dynamic>?)
          ?.map((e) => ScheduledDevotion.fromJson(e as Map<String, dynamic>))
          .toList(),
  scriptureReading: json['scriptureReading'] as String?,
  scriptureText: json['scriptureText'] as String?,
  sharedDevotions:
      (json['sharedDevotions'] as List<dynamic>?)
          ?.map((e) => SharedDevotion.fromJson(e as Map<String, dynamic>))
          .toList(),
  title: json['title'] as String?,
  updatedAt: json['updatedAt'] as String?,
  userNotes:
      (json['userNotes'] as List<dynamic>?)
          ?.map((e) => UserNote.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$DevotionToJson(Devotion instance) => <String, dynamic>{
  'branchId': instance.branchId,
  'createdAt': instance.createdAt,
  'createdBy': instance.createdBy,
  'devotion': instance.devotion,
  'favorites': instance.favorites?.map((e) => e.toJson()).toList(),
  'id': instance.id,
  'organisationId': instance.organisationId,
  'prayer': instance.prayer,
  'scheduledDevotions':
      instance.scheduledDevotions?.map((e) => e.toJson()).toList(),
  'scriptureReading': instance.scriptureReading,
  'scriptureText': instance.scriptureText,
  'sharedDevotions': instance.sharedDevotions?.map((e) => e.toJson()).toList(),
  'title': instance.title,
  'updatedAt': instance.updatedAt,
  'userNotes': instance.userNotes?.map((e) => e.toJson()).toList(),
};
