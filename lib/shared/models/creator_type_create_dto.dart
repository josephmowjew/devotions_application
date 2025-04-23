import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class CreatorTypeCreateDto {
  final String? name;

  const CreatorTypeCreateDto({
    this.name,
  });

  factory CreatorTypeCreateDto.fromJson(Map<String, dynamic> json) => CreatorTypeCreateDto(
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        if (name != null) 'name': name,
      };
}