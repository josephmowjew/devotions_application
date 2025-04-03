import 'package:json_annotation/json_annotation.dart';
import 'favorite.dart';
import 'scheduled_devotion.dart';
import 'shared_devotion.dart';
import 'user_note.dart';

part 'devotion.g.dart';

@JsonSerializable(explicitToJson: true)
class Devotion {
  final String? branchId;
  final String? createdAt;
  final int? createdBy;
  final String? devotion;
  final List<Favorite>? favorites;
  final int? id;
  final int? organisationId;
  final String? prayer;
  final List<ScheduledDevotion>? scheduledDevotions;
  final String? scriptureReading;
  final String? scriptureText;
  final List<SharedDevotion>? sharedDevotions;
  final String? title;
  final String? updatedAt;
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
