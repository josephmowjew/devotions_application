import 'package:flutter/material.dart';

enum ActivityType {
  customerComplaint,
  informationUpdate,
  loanTransfer,
  inboundCall
}

@immutable
class Activity {
  final String id;
  final ActivityType type;
  final String title;
  final String description;
  final DateTime timestamp;
  final String user;
  final String? audioUrl;
  final Map<String, dynamic>? additionalData;
  final String note;
  final bool hasVoiceRecording;
  final String? voiceRecordingTitle;
  final String? voiceRecordingDuration;

  const Activity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.user,
    this.audioUrl,
    this.additionalData,
    this.note = '',
    this.hasVoiceRecording = false,
    this.voiceRecordingTitle,
    this.voiceRecordingDuration,
  });

  Activity copyWith({
    String? id,
    ActivityType? type,
    String? title,
    String? description,
    DateTime? timestamp,
    String? user,
    String? audioUrl,
    Map<String, dynamic>? additionalData,
    String? note,
    bool? hasVoiceRecording,
    String? voiceRecordingTitle,
    String? voiceRecordingDuration,
  }) {
    return Activity(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      user: user ?? this.user,
      audioUrl: audioUrl ?? this.audioUrl,
      additionalData: additionalData ?? this.additionalData,
      note: note ?? this.note,
      hasVoiceRecording: hasVoiceRecording ?? this.hasVoiceRecording,
      voiceRecordingTitle: voiceRecordingTitle ?? this.voiceRecordingTitle,
      voiceRecordingDuration: voiceRecordingDuration ?? this.voiceRecordingDuration,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.toString(),
      'title': title,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'user': user,
      'audioUrl': audioUrl,
      'additionalData': additionalData,
      'note': note,
      'hasVoiceRecording': hasVoiceRecording,
      'voiceRecordingTitle': voiceRecordingTitle,
      'voiceRecordingDuration': voiceRecordingDuration,
    };
  }

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as String,
      type: ActivityType.values.firstWhere(
        (e) => e.toString() == json['type'],
        orElse: () => ActivityType.informationUpdate,
      ),
      title: json['title'] as String,
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      user: json['user'] as String,
      audioUrl: json['audioUrl'] as String?,
      additionalData: json['additionalData'] as Map<String, dynamic>?,
      note: json['note'] as String,
      hasVoiceRecording: json['hasVoiceRecording'] as bool,
      voiceRecordingTitle: json['voiceRecordingTitle'] as String?,
      voiceRecordingDuration: json['voiceRecordingDuration'] as String?,
    );
  }
} 