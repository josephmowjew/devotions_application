import 'package:json_annotation/json_annotation.dart';
import 'devotion.dart';

part 'shared_devotion.g.dart';

@JsonSerializable(explicitToJson: true)
class SharedDevotion {
  final String? branchId;
  final String? createdAt;
  final Devotion? devotion;
  final int? devotionId;
  final String? expireDate;
  final int? expireDefault;
  final int? id;
  final String? link;
  final int? organisationId;
  final String? recipientEmail;
  final String? recipientNumber;
  final String? shareType;
  final String? userId;

  SharedDevotion({
    this.branchId,
    this.createdAt,
    this.devotion,
    this.devotionId,
    this.expireDate,
    this.expireDefault,
    this.id,
    this.link,
    this.organisationId,
    this.recipientEmail,
    this.recipientNumber,
    this.shareType,
    this.userId,
  });

  factory SharedDevotion.fromJson(Map<String, dynamic> json) =>
      _$SharedDevotionFromJson(json);
  Map<String, dynamic> toJson() => _$SharedDevotionToJson(this);
}
