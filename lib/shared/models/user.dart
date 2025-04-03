import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String? createdAt;
  final String? createdBy;
  final int? id;
  final String? name;
  final String? updatedAt;
  final String? updatedBy;

  User({
    this.createdAt,
    this.createdBy,
    this.id,
    this.name,
    this.updatedAt,
    this.updatedBy,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
