import 'package:json_annotation/json_annotation.dart';

part 'direction.g.dart';

@JsonSerializable()
@JsonEnum()
enum Direction {
  @JsonValue('asc')
  asc,
  @JsonValue('desc')
  desc,
}

extension DirectionExtension on Direction {
  String toJsonValue() => _$DirectionEnumMap[this]!;
}
