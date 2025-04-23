
import 'package:json_annotation/json_annotation.dart';
import 'description.dart';

@JsonSerializable(explicitToJson: true)
class ActivityNoteReadDto {
  final Description? description;
  final String? creatorEmail;
  final String? creatorType;
  final int? organizationId;
  final String? branchId;
  final String? icon;
  final String? entityType;
  final int? entityId;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  final String? creatorName;
  final int? id;
  final String? noteType;

  const ActivityNoteReadDto({
    this.description,
    this.creatorEmail,
    this.creatorType,
    this.organizationId,
    this.branchId,
    this.icon,
    this.entityType,
    this.entityId,
    this.createdAt,
    this.creatorName,
    this.id,
    this.noteType,
  });

  factory ActivityNoteReadDto.fromJson(Map<String, dynamic> json) => ActivityNoteReadDto(
        description: json['description'] == null
            ? null
            : Description.fromJson(json['description'] as Map<String, dynamic>),
        creatorEmail: json['creatorEmail'] as String?,
        creatorType: json['creatorType'] as String?,
        organizationId: json['organizationId'] as int?,
        branchId: json['branchId'] as String?,
        icon: json['icon'] as String?,
        entityType: json['entityType'] as String?,
        entityId: json['entityId'] as int?,
        createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
        creatorName: json['creatorName'] as String?,
        id: json['id'] as int?,
        noteType: json['noteType'] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (description != null) 'description': description!.toJson(),
        if (creatorEmail != null) 'creatorEmail': creatorEmail,
        if (creatorType != null) 'creatorType': creatorType,
        if (organizationId != null) 'organizationId': organizationId,
        if (branchId != null) 'branchId': branchId,
        if (icon != null) 'icon': icon,
        if (entityType != null) 'entityType': entityType,
        if (entityId != null) 'entityId': entityId,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
        if (creatorName != null) 'creatorName': creatorName,
        if (id != null) 'id': id,
        if (noteType != null) 'noteType': noteType,
      };
}