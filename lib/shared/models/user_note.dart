import 'package:json_annotation/json_annotation.dart';
import 'devotion.dart';

part 'user_note.g.dart';

@JsonSerializable(explicitToJson: true)
class UserNote {
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

  @JsonKey(name: 'note')
  final String? note;

  @JsonKey(name: 'organisation_id')
  final int? organisationId;

  @JsonKey(name: 'updated_at')
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
