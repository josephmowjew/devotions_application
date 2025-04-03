import 'package:json_annotation/json_annotation.dart';
import 'favorite.dart';
import 'scheduled_devotion.dart';
import 'shared_devotion.dart';
import 'user_note.dart';

part 'devotion.g.dart';

@JsonSerializable(explicitToJson: true)
class Devotion {
  @JsonKey(name: 'branch_id')
  final String? branchId;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'created_by')
  final int? createdBy;

  @JsonKey(name: 'devotion')
  final String? devotion;

  @JsonKey(name: 'favorites')
  final List<Favorite>? favorites;

  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'organisation_id')
  final int? organisationId;

  @JsonKey(name: 'prayer')
  final String? prayer;

  @JsonKey(name: 'scheduled_devotions')
  final List<ScheduledDevotion>? scheduledDevotions;

  @JsonKey(name: 'scripture_reading')
  final String? scriptureReading;

  @JsonKey(name: 'scripture_text')
  final String? scriptureText;

  @JsonKey(name: 'shared_devotions')
  final List<SharedDevotion>? sharedDevotions;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  @JsonKey(name: 'user_notes')
  final List<UserNote>? userNotes;

  Devotion({
    this.branchId,
    this.createdAt,
    this.createdBy,
    this.devotion,
    this.favorites,
    this.id,
    this.organisationId,
    this.prayer,
    this.scheduledDevotions,
    this.scriptureReading,
    this.scriptureText,
    this.sharedDevotions,
    this.title,
    this.updatedAt,
    this.userNotes,
  });

  factory Devotion.fromJson(Map<String, dynamic> json) =>
      _$DevotionFromJson(json);
  Map<String, dynamic> toJson() => _$DevotionToJson(this);
}
