// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Favorite _$FavoriteFromJson(Map<String, dynamic> json) => Favorite(
  branchId: json['branch_id'] as String?,
  createdAt: json['created_at'] as String?,
  devotion:
      json['devotion'] == null
          ? null
          : Devotion.fromJson(json['devotion'] as Map<String, dynamic>),
  devotionId: (json['devotion_id'] as num?)?.toInt(),
  id: (json['id'] as num?)?.toInt(),
  organisationId: (json['organisation_id'] as num?)?.toInt(),
  userId: json['user_id'] as String?,
);

Map<String, dynamic> _$FavoriteToJson(Favorite instance) => <String, dynamic>{
  'branch_id': instance.branchId,
  'created_at': instance.createdAt,
  'devotion': instance.devotion?.toJson(),
  'devotion_id': instance.devotionId,
  'id': instance.id,
  'organisation_id': instance.organisationId,
  'user_id': instance.userId,
};
