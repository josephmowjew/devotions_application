import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class NoteTypeCreateDto {
  final String? name;
  final int? organizationId;
  final String? branchId;

  const NoteTypeCreateDto({
    this.name,
    this.organizationId,
    this.branchId,
  });

  factory NoteTypeCreateDto.fromJson(Map<String, dynamic> json) => NoteTypeCreateDto(
        name: json['name'] as String?,
        organizationId: json['organizationId'] as int?,
        branchId: json['branchId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (organizationId != null) 'organizationId': organizationId,
        if (branchId != null) 'branchId': branchId,
      };
}