// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
  content: json['content'],
  empty: json['empty'] as bool?,
  first: json['first'] as bool?,
  last: json['last'] as bool?,
  number: (json['number'] as num?)?.toInt(),
  numberOfElements: (json['numberOfElements'] as num?)?.toInt(),
  pageable:
      json['pageable'] == null
          ? null
          : Pageable.fromJson(json['pageable'] as Map<String, dynamic>),
  size: (json['size'] as num?)?.toInt(),
  sort:
      json['sort'] == null
          ? null
          : Options.fromJson(json['sort'] as Map<String, dynamic>),
  totalElements: (json['totalElements'] as num?)?.toInt(),
  totalPages: (json['totalPages'] as num?)?.toInt(),
);

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
  'content': instance.content,
  'empty': instance.empty,
  'first': instance.first,
  'last': instance.last,
  'number': instance.number,
  'numberOfElements': instance.numberOfElements,
  'pageable': instance.pageable?.toJson(),
  'size': instance.size,
  'sort': instance.sort?.toJson(),
  'totalElements': instance.totalElements,
  'totalPages': instance.totalPages,
};
