import 'package:json_annotation/json_annotation.dart';
import 'options.dart';

part 'pageable.g.dart';

@JsonSerializable(explicitToJson: true)
class Pageable {
  final int? offset;
  final int? pageNumber;
  final int? pageSize;
  final bool? paged;
  final Options? sort;
  final bool? unpaged;

  Pageable({
    this.offset,
    this.pageNumber,
    this.pageSize,
    this.paged,
    this.sort,
    this.unpaged,
  });

  factory Pageable.fromJson(Map<String, dynamic> json) =>
      _$PageableFromJson(json);
  Map<String, dynamic> toJson() => _$PageableToJson(this);
}
