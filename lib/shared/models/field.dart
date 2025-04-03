import 'package:json_annotation/json_annotation.dart';
import 'direction.dart';

part 'field.g.dart';

@JsonSerializable(explicitToJson: true)
class Field {
  @JsonKey(name: 'case_sensitive')
  final bool? caseSensitive;
  final Direction? direction;
  final String? name;

  Field({this.caseSensitive, this.direction, this.name});

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);
  Map<String, dynamic> toJson() => _$FieldToJson(this);
}
