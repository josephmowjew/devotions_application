import 'package:json_annotation/json_annotation.dart';
import 'devotion.dart';

part 'favorite.g.dart';

@JsonSerializable(explicitToJson: true)
class Favorite {
  final String? branchId;
  final String? createdAt;
  final Devotion? devotion;
  final int? devotionId;
  final int? id;
  final int? organisationId;
  final String? userId;

  Favorite({
    this.branchId,
    this.createdAt,
    this.devotion,
    this.devotionId,
    this.id,
    this.organisationId,
    this.userId,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteToJson(this);
}
