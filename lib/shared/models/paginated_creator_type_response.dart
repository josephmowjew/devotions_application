import 'creator_type_read_dto.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class PaginatedCreatorTypeResponse {
  final List<CreatorTypeReadDto>? creatorTypes;
  final int? page;
  final int? pageSize;
  final int? totalElements;
  final int? totalPages;

  const PaginatedCreatorTypeResponse({
    this.creatorTypes,
    this.page,
    this.pageSize,
    this.totalElements,
    this.totalPages,
  });

  factory PaginatedCreatorTypeResponse.fromJson(Map<String, dynamic> json) =>
      PaginatedCreatorTypeResponse(
        creatorTypes: (json['creatorTypes'] as List<dynamic>?)
            ?.map((e) => CreatorTypeReadDto.fromJson(e as Map<String, dynamic>))
            .toList(),
        page: json['page'] as int?,
        pageSize: json['pageSize'] as int?,
        totalElements: json['totalElements'] as int?,
        totalPages: json['totalPages'] as int?,
      );

  Map<String, dynamic> toJson() => {
        if (creatorTypes != null) 'creatorTypes': creatorTypes!.map((e) => e.toJson()).toList(),
        if (page != null) 'page': page,
        if (pageSize != null) 'pageSize': pageSize,
        if (totalElements != null) 'totalElements': totalElements,
        if (totalPages != null) 'totalPages': totalPages,
      };
}