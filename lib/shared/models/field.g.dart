// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
  caseSensitive: json['case_sensitive'] as bool?,
  direction: $enumDecodeNullable(_$DirectionEnumMap, json['direction']),
  name: json['name'] as String?,
);

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
  'case_sensitive': instance.caseSensitive,
  'direction': _$DirectionEnumMap[instance.direction],
  'name': instance.name,
};

const _$DirectionEnumMap = {Direction.asc: 'asc', Direction.desc: 'desc'};
