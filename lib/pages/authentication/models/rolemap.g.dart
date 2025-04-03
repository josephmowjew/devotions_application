// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rolemap.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rolemap _$RolemapFromJson(Map<String, dynamic> json) => Rolemap(
  roleMapId: (json['roleMapId'] as num?)?.toInt(),
  organisationalId: (json['organisationalId'] as num?)?.toInt(),
  branchId: json['branchId'] as String?,
  role:
      json['role'] == null
          ? null
          : Role.fromJson(json['role'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RolemapToJson(Rolemap instance) => <String, dynamic>{
  'roleMapId': instance.roleMapId,
  'organisationalId': instance.organisationalId,
  'branchId': instance.branchId,
  'role': instance.role,
};
