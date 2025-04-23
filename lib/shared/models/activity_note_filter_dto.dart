import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class ActivityNoteFilterDto {
  final int? organizationId;
  final String? branchId;
  final List<String>? noteType;
  final String? creatorEmail;
  final List<String>? creatorType;
  final List<String>? entityType;
  @JsonKey(name: 'startDate')
  final DateTime? startDate;
  @JsonKey(name: 'endDate')
  final DateTime? endDate;
  final List<String>? entityId;
  final String? searchKeyword;
  final int? page;
  final int? pageSize;

  const ActivityNoteFilterDto({
    this.organizationId,
    this.branchId,
    this.noteType,
    this.creatorEmail,
    this.creatorType,
    this.entityType,
    this.startDate,
    this.endDate,
    this.entityId,
    this.searchKeyword,
    this.page,
    this.pageSize,
  });

  factory ActivityNoteFilterDto.fromJson(Map<String, dynamic> json) => ActivityNoteFilterDto(
        organizationId: json['organizationId'] as int?,
        branchId: json['branchId'] as String?,
        noteType: (json['noteType'] as List<dynamic>?)?.map((e) => e as String).toList(),
        creatorEmail: json['creatorEmail'] as String?,
        creatorType: (json['creatorType'] as List<dynamic>?)?.map((e) => e as String).toList(),
        entityType: (json['entityType'] as List<dynamic>?)?.map((e) => e as String).toList(),
        startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'] as String),
        endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'] as String),
        entityId: (json['entityId'] as List<dynamic>?)?.map((e) => e as String).toList(),
        searchKeyword: json['searchKeyword'] as String?,
        page: json['page'] as int?,
        pageSize: json['pageSize'] as int?,
      );

  Map<String, dynamic> toJson() => {
        if (organizationId != null) 'organizationId': organizationId,
        if (branchId != null) 'branchId': branchId,
        if (noteType != null) 'noteType': noteType,
        if (creatorEmail != null) 'creatorEmail': creatorEmail,
        if (creatorType != null) 'creatorType': creatorType,
        if (entityType != null) 'entityType': entityType,
        if (startDate != null) 'startDate': startDate!.toIso8601String(),
        if (endDate != null) 'endDate': endDate!.toIso8601String(),
        if (entityId != null) 'entityId': entityId,
        if (searchKeyword != null) 'searchKeyword': searchKeyword,
        if (page != null) 'page': page,
        if (pageSize != null) 'pageSize': pageSize,
      };
}