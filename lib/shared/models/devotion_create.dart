import 'package:json_annotation/json_annotation.dart';

part 'devotion_create.g.dart';

@JsonSerializable(explicitToJson: true)
class DevotionCreate {
  @JsonKey(name: 'created_by')
  final int? createdBy;

  @JsonKey(name: 'devotion')
  final String? devotion;

  @JsonKey(name: 'prayer')
  final String? prayer;

  @JsonKey(name: 'scripture_reading')
  final String? scriptureReading;

  @JsonKey(name: 'scripture_text')
  final String? scriptureText;

  @JsonKey(name: 'title')
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
