import 'package:json_annotation/json_annotation.dart';

part 'scheduled_devotion_create.g.dart';

@JsonSerializable(explicitToJson: true)
class ScheduledDevotionCreate {
  final int? devotionId;
  final String? scheduledDate;

  ScheduledDevotionCreate({this.devotionId, this.scheduledDate});

  factory ScheduledDevotionCreate.fromJson(Map<String, dynamic> json) =>
      _$ScheduledDevotionCreateFromJson(json);
  Map<String, dynamic> toJson() => _$ScheduledDevotionCreateToJson(this);
}
