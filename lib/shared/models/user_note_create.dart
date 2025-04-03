import 'package:json_annotation/json_annotation.dart';

part 'user_note_create.g.dart';

@JsonSerializable(explicitToJson: true)
class UserNoteCreate {
  final int? devotionId;
  final String? note;

  UserNoteCreate({this.devotionId, this.note});

  factory UserNoteCreate.fromJson(Map<String, dynamic> json) =>
      _$UserNoteCreateFromJson(json);
  Map<String, dynamic> toJson() => _$UserNoteCreateToJson(this);
}
