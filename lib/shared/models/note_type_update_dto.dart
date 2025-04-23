import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class NoteTypeUpdateDto {
  final String? name;
  final int? organizationId;
  final String? branchId;

  const NoteTypeUpdateDto({
    this.name,
    this.organizationId,
    this.branchId,
  });

  factory NoteTypeUpdateDto.fromJson(Map<String, dynamic> json) => NoteTypeUpdateDto(
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