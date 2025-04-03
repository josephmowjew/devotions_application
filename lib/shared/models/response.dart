import 'package:json_annotation/json_annotation.dart';
import 'pageable.dart';
import 'options.dart';

part 'response.g.dart';

@JsonSerializable(explicitToJson: true)
class Response {
  @JsonKey(name: 'content')
  final dynamic content; // Using dynamic since Swagger doesn't specify content type

  @JsonKey(name: 'empty')
  final bool? empty;

  @JsonKey(name: 'first')
  final bool? first;

  @JsonKey(name: 'last')
  final bool? last;

  @JsonKey(name: 'number')
  final int? number;

  @JsonKey(name: 'numberOfElements')
  final int? numberOfElements;

  @JsonKey(name: 'pageable')
  final Pageable? pageable;

  @JsonKey(name: 'size')
  final int? size;

  @JsonKey(name: 'sort')
  final Options? sort;

  @JsonKey(name: 'totalElements')
  final int? totalElements;

  @JsonKey(name: 'totalPages')
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
