// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  createdAt: json['createdAt'] as String?,
  createdBy: json['createdBy'] as String?,
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  updatedAt: json['updatedAt'] as String?,
  updatedBy: json['updatedBy'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'createdAt': instance.createdAt,
  'createdBy': instance.createdBy,
  'id': instance.id,
  'name': instance.name,
  'updatedAt': instance.updatedAt,
  'updatedBy': instance.updatedBy,
};
