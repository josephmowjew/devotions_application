import 'package:json_annotation/json_annotation.dart';
import 'devotion.dart';

part 'scheduled_devotion.g.dart';

@JsonSerializable(explicitToJson: true)
class ScheduledDevotion {
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

  @JsonKey(name: 'scheduled_date')
  final String? scheduledDate;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  ScheduledDevotion({
    this.branchId,
    this.createdAt,
    this.devotion,
    this.devotionId,
    this.id,
    this.organisationId,
    this.scheduledDate,
    this.updatedAt,
  });

  factory ScheduledDevotion.fromJson(Map<String, dynamic> json) =>
      _$ScheduledDevotionFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduledDevotionToJson(this);
}
