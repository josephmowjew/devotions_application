import 'package:json_annotation/json_annotation.dart';
import 'devotion.dart';

part 'user_note.g.dart';

@JsonSerializable(explicitToJson: true)
class UserNote {
  final String? branchId;
  final String? createdAt;
  final Devotion? devotion;
  final int? devotionId;
  final int? id;
  final String? note;
  final int? organisationId;
  final String? updatedAt;

  UserNote({
    this.branchId,
    this.createdAt,
    this.devotion,
    this.devotionId,
    this.id,
    this.note,
    this.organisationId,
    this.updatedAt,
  });

  factory UserNote.fromJson(Map<String, dynamic> json) =>
      _$UserNoteFromJson(json);
  Map<String, dynamic> toJson() => _$UserNoteToJson(this);
}
