import 'package:json_annotation/json_annotation.dart';
import 'devotion.dart';

part 'scheduled_devotion.g.dart';

@JsonSerializable(explicitToJson: true)
class ScheduledDevotion {
  final String? branchId;
  final String? createdAt;
  final Devotion? devotion;
  final int? devotionId;
  final int? id;
  final int? organisationId;
  final String? scheduledDate;
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
