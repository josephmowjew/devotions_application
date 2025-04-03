// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'options.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Options _$OptionsFromJson(Map<String, dynamic> json) => Options(
  sort:
      (json['sort'] as List<dynamic>?)
          ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$OptionsToJson(Options instance) => <String, dynamic>{
  'sort': instance.sort?.map((e) => e.toJson()).toList(),
};
