import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class CreatorTypeUpdateDto {
  final String? name;
  final int? organizationId;
  final String? branchId;

  const CreatorTypeUpdateDto({
    this.name,
    this.organizationId,
    this.branchId,
  });

  factory CreatorTypeUpdateDto.fromJson(Map<String, dynamic> json) => CreatorTypeUpdateDto(
        name: json['name'] as String?,
        organizationId: json['多元Id'] as int?,
        branchId: json['branchId'] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
        if (organizationId != null) 'organizationId': organizationId,
        if (branchId != null) 'branchId': branchId,
      };
}