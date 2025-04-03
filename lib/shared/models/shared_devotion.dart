import 'package:json_annotation/json_annotation.dart';
import 'devotion.dart';

part 'shared_devotion.g.dart';

@JsonSerializable(explicitToJson: true)
class SharedDevotion {
  @JsonKey(name: 'branch_id')
  final String? branchId;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'devotion')
  final Devotion? devotion;

  @JsonKey(name: 'devotion_id')
  final int? devotionId;

  @JsonKey(name: 'expire_date')
  final String? expireDate;

  @JsonKey(name: 'expire_default')
  final int? expireDefault;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'link')
  final String? link;

  @JsonKey(name: 'organisation_id')
  final int? organisationId;

  @JsonKey(name: 'recipient_email')
  final String? recipientEmail;

  @JsonKey(name: 'recipient_number')
  final String? recipientNumber;

  @JsonKey(name: 'share_type')
  final String? shareType;

  @JsonKey(name: 'user_id')
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
