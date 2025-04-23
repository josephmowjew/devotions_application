import 'package:flutter/material.dart';

class ActivityNotesTheme {
  // Colors
  static const backgroundColor = Colors.white;
  static const searchBackground = Color(0xFFF5F5F5);
  static const titleText = Color(0xFF1A1A1A);
  static const subtitleText = Color(0xFF666666);
  static const descriptionText = Color(0xFF808080);
  static const iconBackground = Color(0xFFF5F5F5);
  static const timelineConnector = Color(0xFFE0E0E0);
  static const audioPlayerBackground = Color(0xFFF5F5F5);
  static const searchIconColor = Color(0xFF666666);
  static const dividerColor = Color(0xFFE0E0E0);

  // Border Radius
  static const searchBorderRadius = 24.0;
  static const audioPlayerBorderRadius = 8.0;
  static const cardBorderRadius = 8.0;

  // Typography
  static const titleStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: titleText,
    height: 1.5,
  );

  static const timestampStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: subtitleText,
    height: 1.4,
  );

  static const descriptionStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: descriptionText,
    height: 1.4,
  );

  // Spacing
  static const double verticalSpacing = 24.0;
  static const double horizontalSpacing = 16.0;
  static const double iconSize = 40.0;
  static const double timelineWidth = 2.0;
} 