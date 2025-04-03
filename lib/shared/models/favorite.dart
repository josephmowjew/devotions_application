import 'package:json_annotation/json_annotation.dart';
import 'devotion.dart';

part 'favorite.g.dart';

@JsonSerializable(explicitToJson: true)
class Favorite {
  @JsonKey(name: 'branch_id')
  final String? branchId;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'devotion')
  final Devotion? devotion;

  @JsonKey(name: 'devotion_id')
  final int? devotionId;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'organisation_id')
  final int? organisationId;

  @JsonKey(name: 'user_id')
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
