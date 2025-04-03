// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageable.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Pageable _$PageableFromJson(Map<String, dynamic> json) => Pageable(
  offset: (json['offset'] as num?)?.toInt(),
  pageNumber: (json['pageNumber'] as num?)?.toInt(),
  pageSize: (json['pageSize'] as num?)?.toInt(),
  paged: json['paged'] as bool?,
  sort:
      json['sort'] == null
          ? null
          : Options.fromJson(json['sort'] as Map<String, dynamic>),
  unpaged: json['unpaged'] as bool?,
);

Map<String, dynamic> _$PageableToJson(Pageable instance) => <String, dynamic>{
  'offset': instance.offset,
  'pageNumber': instance.pageNumber,
  'pageSize': instance.pageSize,
  'paged': instance.paged,
  'sort': instance.sort?.toJson(),
  'unpaged': instance.unpaged,
};
