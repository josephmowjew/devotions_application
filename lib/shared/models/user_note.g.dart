// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNote _$UserNoteFromJson(Map<String, dynamic> json) => UserNote(
  branchId: json['branch_id'] as String?,
  createdAt: json['created_at'] as String?,
  devotion:
      json['devotion'] == null
          ? null
          : Devotion.fromJson(json['devotion'] as Map<String, dynamic>),
  devotionId: (json['devotion_id'] as num?)?.toInt(),
  id: (json['id'] as num?)?.toInt(),
  note: json['note'] as String?,
  organisationId: (json['organisation_id'] as num?)?.toInt(),
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$UserNoteToJson(UserNote instance) => <String, dynamic>{
  'branch_id': instance.branchId,
  'created_at': instance.createdAt,
  'devotion': instance.devotion?.toJson(),
  'devotion_id': instance.devotionId,
  'id': instance.id,
  'note': instance.note,
  'organisation_id': instance.organisationId,
  'updated_at': instance.updatedAt,
};
