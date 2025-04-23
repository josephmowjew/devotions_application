import 'sort_object.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class PageableObject {
  final int? offset;
  final SortObject? sort;
  final bool? unpaged;
  final bool? paged;
  final int? pageNumber;
  final int? pageSize;

  const PageableObject({
    this.offset,
    this.sort,
    this.unpaged,
    this.paged,
    this.pageNumber,
    this.pageSize,
  });

  factory PageableObject.fromJson(Map<String, dynamic> json) => PageableObject(
        offset: json['offset'] as int?,
        sort: json['sort'] == null ? null : SortObject.fromJson(json['sort'] as Map<String, dynamic>),
        unpaged: json['unpaged'] as bool?,
        paged: json['paged'] as bool?,
        pageNumber: json['pageNumber'] as int?,
        pageSize: json['pageSize'] as int?,
      );

  Map<String, dynamic> toJson() => {
        if (offset != null) 'offset': offset,
        if (sort != null) 'sort': sort!.toJson(),
        if (unpaged != null) 'unpaged': unpaged,
        if (paged != null) 'paged': paged,
        if (pageNumber != null) 'pageNumber': pageNumber,
        if (pageSize != null) 'pageSize': pageSize,
      };
}