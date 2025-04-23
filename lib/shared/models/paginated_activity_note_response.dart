import 'activity_note_read_dto.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class PaginatedActivityNoteResponse {
  final List<ActivityNoteReadDto>? content;
  final int? pageNumber;
  final int? pageSize;
  final int? totalElements;
  final int? totalPages;

  const PaginatedActivityNoteResponse({
    this.content,
    this.pageNumber,
    this.pageSize,
    this.totalElements,
    this.totalPages,
  });

  factory PaginatedActivityNoteResponse.fromJson(Map<String, dynamic> json) =>
      PaginatedActivityNoteResponse(
        content: (json['content'] as List<dynamic>?)
            ?.map((e) => ActivityNoteReadDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        pageNumber: json['pageNumber'] as int?,
        pageSize: json['pageSize'] as int?,
        totalElements: json['totalElements'] as int?,
        totalPages: json['totalPages'] as int?,
      );

  Map<String, dynamic> toJson() => {
        if (content != null) 'content': content!.map((e) => e.toJson()).toList(),
        if (pageNumber != null) 'pageNumber': pageNumber,
        if (pageSize != null) 'pageSize': pageSize,
        if (totalElements != null) 'totalElements': totalElements,
        if (totalPages != null) 'totalPages': totalPages,
      };
}