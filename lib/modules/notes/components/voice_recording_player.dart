import 'package:flutter/material.dart';

class VoiceRecordingPlayer extends StatefulWidget {
  final String title;
  final String duration;
  final VoidCallback? onPlay;
  final VoidCallback? onMoreOptions;

  const VoiceRecordingPlayer({
    super.key,
    required this.title,
    this.duration = "01:45",
    this.onPlay,
    this.onMoreOptions,
  });

  @override
  State<VoiceRecordingPlayer> createState() => _VoiceRecordingPlayerState();
}

class _VoiceRecordingPlayerState extends State<VoiceRecordingPlayer> {
  bool _isPlaying = false;
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF666666),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                // Play button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPlaying = !_isPlaying;
                      });
                      widget.onPlay?.call();
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF666666),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Progress slider
                Expanded(
                  child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 3,
                      activeTrackColor: const Color(0xFF2196F3),
                      inactiveTrackColor: Colors.white,
                      thumbColor: const Color(0xFF2196F3),
                      overlayColor: const Color(0xFF2196F3).withOpacity(0.2),
                      thumbShape: const RoundSliderThumbShape(
                        enabledThumbRadius: 6,
                      ),
                      overlayShape: const RoundSliderOverlayShape(
                        overlayRadius: 12,
                      ),
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
                const SizedBox(width: 16),
                // Duration
                Text(
                  widget.duration,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                // More options button
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: widget.onMoreOptions,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Color(0xFF666666),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 