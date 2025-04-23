import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../utils/activity_formatter.dart';
import '../utils/theme_constants.dart';
import 'activity_icons.dart';
import 'activity_audio_player.dart';
import 'voice_recording_player.dart';

class ActivityItem extends StatelessWidget {
  final Activity activity;
  final bool isLast;

  const ActivityItem({
    Key? key,
    required this.activity,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline column with icon and line
          SizedBox(
            width: ActivityNotesTheme.iconSize,
            child: Column(
              children: [
                ActivityIcons.getActivityIconWithBackground(activity.type),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: ActivityNotesTheme.timelineWidth,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: ActivityNotesTheme.timelineConnector,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: ActivityNotesTheme.horizontalSpacing),
          // Content column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title and timestamp
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ActivityFormatter.getActivityTitle(activity),
                      style: ActivityNotesTheme.titleStyle,
                    ),
                    Text(
                      " - ",
                      style: ActivityNotesTheme.titleStyle,
                    ),
                    Expanded(
                      child: Text(
                        ActivityFormatter.formatActivityTimestamp(activity),
                        style: ActivityNotesTheme.timestampStyle,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Description container - will fill width due to crossAxisAlignment.stretch above
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: ActivityNotesTheme.searchBackground,
                    borderRadius: BorderRadius.circular(ActivityNotesTheme.cardBorderRadius),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.description,
                        style: ActivityNotesTheme.descriptionStyle,
                      ),
                      if (activity.type == ActivityType.inboundCall && activity.audioUrl != null) ...[
                        const SizedBox(height: 12),
                        ActivityAudioPlayer(audioUrl: activity.audioUrl!),
                      ],
                      // Note content
                      if (activity.note.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          activity.note,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            height: 1.5,
                          ),
                        ),
                      ],
                      // Voice recording player
                      if (activity.hasVoiceRecording) ...[
                        const SizedBox(height: 16),
                        VoiceRecordingPlayer(
                          title: activity.voiceRecordingTitle ?? 'Voice Recording',
                          duration: activity.voiceRecordingDuration ?? '00:00',
                          onPlay: () {
                            // Handle play/pause
                          },
                          onMoreOptions: () {
                            // Handle more options
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                if (!isLast)
                  const SizedBox(height: ActivityNotesTheme.verticalSpacing),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 