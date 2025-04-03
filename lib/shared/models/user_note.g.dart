// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNote _$UserNoteFromJson(Map<String, dynamic> json) => UserNote(
  branchId: json['branchId'] as String?,
  createdAt: json['createdAt'] as String?,
  devotion:
      json['devotion'] == null
          ? null
          : Devotion.fromJson(json['devotion'] as Map<String, dynamic>),
  devotionId: (json['devotionId'] as num?)?.toInt(),
  id: (json['id'] as num?)?.toInt(),
  note: json['note'] as String?,
  organisationId: (json['organisationId'] as num?)?.toInt(),
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$UserNoteToJson(UserNote instance) => <String, dynamic>{
  'branchId': instance.branchId,
  'createdAt': instance.createdAt,
  'devotion': instance.devotion?.toJson(),
  'devotionId': instance.devotionId,
  'id': instance.id,
  'note': instance.note,
  'organisationId': instance.organisationId,
  'updatedAt': instance.updatedAt,
};
