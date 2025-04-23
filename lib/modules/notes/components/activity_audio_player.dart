import 'package:flutter/material.dart';
import '../utils/theme_constants.dart';

class ActivityAudioPlayer extends StatefulWidget {
  final String audioUrl;

  const ActivityAudioPlayer({
    Key? key,
    required this.audioUrl,
  }) : super(key: key);

  @override
  State<ActivityAudioPlayer> createState() => _ActivityAudioPlayerState();
}

class _ActivityAudioPlayerState extends State<ActivityAudioPlayer> {
  bool _isPlaying = false;
  double _progress = 0.0;

  void _togglePlayPause() {
    // TODO: Implement actual audio playback
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _showOptions() {
    // TODO: Implement options menu
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: ActivityNotesTheme.audioPlayerBackground,
        borderRadius: BorderRadius.circular(ActivityNotesTheme.audioPlayerBorderRadius),
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
              color: ActivityNotesTheme.titleText,
              size: 24,
            ),
            onPressed: _togglePlayPause,
            padding: EdgeInsets.zero,
          ),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 4,
                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                overlayShape: const RoundSliderOverlayShape(overlayRadius: 14),
                activeTrackColor: ActivityNotesTheme.titleText,
                inactiveTrackColor: ActivityNotesTheme.titleText.withOpacity(0.2),
                thumbColor: ActivityNotesTheme.titleText,
                overlayColor: ActivityNotesTheme.titleText.withOpacity(0.1),
              ),
              child: Slider(
                value: _progress,
                onChanged: (value) {
                  setState(() {
                    _progress = value;
                  });
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '01:45',
              style: ActivityNotesTheme.timestampStyle.copyWith(
                fontSize: 12,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: ActivityNotesTheme.titleText,
              size: 20,
            ),
            onPressed: _showOptions,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
} 