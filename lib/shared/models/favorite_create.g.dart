// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_create.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteCreate _$FavoriteCreateFromJson(Map<String, dynamic> json) =>
    FavoriteCreate(
      devotionId: (json['devotionId'] as num?)?.toInt(),
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$FavoriteCreateToJson(FavoriteCreate instance) =>
    <String, dynamic>{
      'devotionId': instance.devotionId,
      'userId': instance.userId,
    };
