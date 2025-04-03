import 'package:json_annotation/json_annotation.dart';
import 'field.dart';

part 'options.g.dart';

@JsonSerializable(explicitToJson: true)
class Options {
  final List<Field>? sort;

  Options({this.sort});

  factory Options.fromJson(Map<String, dynamic> json) =>
      _$OptionsFromJson(json);
  Map<String, dynamic> toJson() => _$OptionsToJson(this);
}
