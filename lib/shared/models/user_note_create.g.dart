// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_note_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNoteCreate _$UserNoteCreateFromJson(Map<String, dynamic> json) =>
    UserNoteCreate(
      devotionId: (json['devotionId'] as num?)?.toInt(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$UserNoteCreateToJson(UserNoteCreate instance) =>
    <String, dynamic>{'devotionId': instance.devotionId, 'note': instance.note};
