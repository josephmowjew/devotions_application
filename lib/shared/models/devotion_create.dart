import 'package:json_annotation/json_annotation.dart';

part 'devotion_create.g.dart';

@JsonSerializable(explicitToJson: true)
class DevotionCreate {
  final int? createdBy;
  final String? devotion;
  final String? prayer;
  final String? scriptureReading;
  final String? scriptureText;
  final String? title;

  DevotionCreate({
    this.createdBy,
    this.devotion,
    this.prayer,
    this.scriptureReading,
    this.scriptureText,
    this.title,
  });

  factory DevotionCreate.fromJson(Map<String, dynamic> json) =>
      _$DevotionCreateFromJson(json);
  Map<String, dynamic> toJson() => _$DevotionCreateToJson(this);
}
