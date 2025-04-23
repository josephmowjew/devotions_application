import 'activity_note_read_dto.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class ActivityNoteCreateResponseDto {
  final ActivityNoteReadDto? activityNote;
  final String? message;
  final bool? newlyCreated;

  const ActivityNoteCreateResponseDto({
    this.activityNote,
    this.message,
    this.newlyCreated,
  });

  factory ActivityNoteCreateResponseDto.fromJson(Map<String, dynamic> json) =>
      ActivityNoteCreateResponseDto(
        activityNote: json['activityNote'] == null
            ? null
            : ActivityNoteReadDto.fromJson(json['activityNote'] as Map<String, dynamic>),
        message: json['message'] as String?,
        newlyCreated: json['newlyCreated'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        if (activityNote != null) 'activityNote': activityNote!.toJson(),
        if (message != null) 'message': message,
        if (newlyCreated != null) 'newlyCreated': newlyCreated,
      };
}