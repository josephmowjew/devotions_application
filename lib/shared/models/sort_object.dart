import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class SortObject {
  final bool? empty;
  final bool? unsorted;
  final bool? sorted;

  const SortObject({
    this.empty,
    this.unsorted,
    this.sorted,
  });

  factory SortObject.fromJson(Map<String, dynamic> json) => SortObject(
        empty: json['empty'] as bool?,
        unsorted: json['unsorted'] as bool?,
        sorted: json['sorted'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        if (empty != null) 'empty': empty,
        if (unsorted != null) 'unsorted': unsorted,
        if (sorted != null) 'sorted': sorted,
      };
}