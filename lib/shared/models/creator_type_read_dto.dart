import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class CreatorTypeReadDto {
  final int? id;
  final String? name;
  final int? organizationId;
  final String? branchId;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  const CreatorTypeReadDto({
    this.id,
    this.name,
    this.organizationId,
    this.branchId,
    this.createdAt,
  });

  factory CreatorTypeReadDto.fromJson(Map<String, dynamic> json) => CreatorTypeReadDto(
        id: json['id'] as int?,
        name: json['name'] as String?,
        organizationId: json['organizationId'] as int?,
        branchId: json['branchId'] as String?,
        createdAt: json['createdAt'] == null ? null : DateTime.parse(json['createdAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (organizationId != null) 'organizationId': organizationId,
        if (branchId != null) 'branchId': branchId,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      };
}