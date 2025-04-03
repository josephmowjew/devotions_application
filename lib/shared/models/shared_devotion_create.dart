import 'package:json_annotation/json_annotation.dart';

part 'shared_devotion_create.g.dart';

@JsonSerializable(explicitToJson: true)
class SharedDevotionCreate {
  final int? devotionId;
  final String? expireDate;
  final int? expireDefault;
  final String? link;
  final String? recipientEmail;
  final String? recipientNumber;
  final String? shareType;
  final String? userId;

  SharedDevotionCreate({
    this.devotionId,
    this.expireDate,
    this.expireDefault,
    this.link,
    this.recipientEmail,
    this.recipientNumber,
    this.shareType,
    this.userId,
  });

  factory SharedDevotionCreate.fromJson(Map<String, dynamic> json) =>
      _$SharedDevotionCreateFromJson(json);
  Map<String, dynamic> toJson() => _$SharedDevotionCreateToJson(this);
}
