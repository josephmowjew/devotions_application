// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'devotion_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DevotionCreate _$DevotionCreateFromJson(Map<String, dynamic> json) =>
    DevotionCreate(
      createdBy: (json['createdBy'] as num?)?.toInt(),
      devotion: json['devotion'] as String?,
      prayer: json['prayer'] as String?,
      scriptureReading: json['scriptureReading'] as String?,
      scriptureText: json['scriptureText'] as String?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$DevotionCreateToJson(DevotionCreate instance) =>
    <String, dynamic>{
      'createdBy': instance.createdBy,
      'devotion': instance.devotion,
      'prayer': instance.prayer,
      'scriptureReading': instance.scriptureReading,
      'scriptureText': instance.scriptureText,
      'title': instance.title,
    };
