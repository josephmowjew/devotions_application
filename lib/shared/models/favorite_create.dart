import 'package:json_annotation/json_annotation.dart';

part 'favorite_create.g.dart';

@JsonSerializable(explicitToJson: true)
class FavoriteCreate {
  final int? devotionId;
  final String? userId;

  FavoriteCreate({this.devotionId, this.userId});

  factory FavoriteCreate.fromJson(Map<String, dynamic> json) =>
      _$FavoriteCreateFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteCreateToJson(this);
}
