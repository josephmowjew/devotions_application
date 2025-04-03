// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorite _$FavoriteFromJson(Map<String, dynamic> json) => Favorite(
  branchId: json['branchId'] as String?,
  createdAt: json['createdAt'] as String?,
  devotion:
      json['devotion'] == null
          ? null
          : Devotion.fromJson(json['devotion'] as Map<String, dynamic>),
  devotionId: (json['devotionId'] as num?)?.toInt(),
  id: (json['id'] as num?)?.toInt(),
  organisationId: (json['organisationId'] as num?)?.toInt(),
  userId: json['userId'] as String?,
);

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
  'branchId': instance.branchId,
  'createdAt': instance.createdAt,
  'devotion': instance.devotion?.toJson(),
  'devotionId': instance.devotionId,
  'id': instance.id,
  'organisationId': instance.organisationId,
  'userId': instance.userId,
};
