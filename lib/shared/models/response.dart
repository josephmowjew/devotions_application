import 'package:json_annotation/json_annotation.dart';
import 'pageable.dart';
import 'options.dart';

part 'response.g.dart';

@JsonSerializable(explicitToJson: true)
class Response {
  final dynamic
  content; // Using dynamic since Swagger doesn't specify content type
  final bool? empty;
  final bool? first;
  final bool? last;
  final int? number;
  final int? numberOfElements;
  final Pageable? pageable;
  final int? size;
  final Options? sort;
  final int? totalElements;
  final int? totalPages;

  Response({
    this.content,
    this.empty,
    this.first,
    this.last,
    this.number,
    this.numberOfElements,
    this.pageable,
    this.size,
    this.sort,
    this.totalElements,
    this.totalPages,
  });

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResponseToJson(this);
}
