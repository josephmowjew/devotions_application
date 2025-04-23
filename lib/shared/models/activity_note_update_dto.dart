import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class ActivityNoteUpdateDto {
  final String? noteTypeName;
  final String? text;
  final String? url;
  final String? urlTitle;
  final String? creatorEmail;
  final int? organizationId;
  final String? branchId;
  final String? icon;
  final String? entityType;
  final int? entityId;
  final String? creatorTypeName;

  const ActivityNoteUpdateDto({
    this.noteTypeName,
    this.text,
    this.url,
    this.urlTitle,
    this.creatorEmail,
    this.organizationId,
    this.branchId,
    this.icon,
    this.entityType,
    this.entityId,
    this.creatorTypeName,
  });

  factory ActivityNoteUpdateDto.fromJson(Map<String, dynamic> json) => ActivityNoteUpdateDto(
        noteTypeName: json['noteTypeName'] as String?,
        text: json['text'] as String?,
        url: json['url'] as String?,
        urlTitle: json['urlTitle'] as String?,
        creatorEmail: json['creatorEmail'] as String?,
        organizationId: json['organizationId'] as int?,
        branchId: json['branchId'] as String?,
        icon: json['icon'] as String?,
        entityType: json['entityType'] as String?,
        entityId: json['entityId'] as int?,
        creatorTypeName: json['creatorTypeName'] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (noteTypeName != null) 'noteTypeName': noteTypeName,
        if (text != null) 'text': text,
        if (url != null) 'url': url,
        if (urlTitle != null) 'urlTitle': urlTitle,
        if (creatorEmail != null) 'creatorEmail': creatorEmail,
        if (organizationId != null) 'organizationId': organizationId,
        if (branchId != null) 'branchId': branchId,
        if (icon != null) 'icon': icon,
        if (entityType != null) 'entityType': entityType,
        if (entityId != null) 'entityId': entityId,
        if (creatorTypeName != null) 'creatorTypeName': creatorTypeName,
      };
}