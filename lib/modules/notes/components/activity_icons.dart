import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../utils/theme_constants.dart';

class ActivityIcons {
  static Icon getActivityIcon(ActivityType type) {
    switch (type) {
      case ActivityType.customerComplaint:
        return const Icon(
          Icons.headset_mic_outlined,
          size: 20,
        );
      case ActivityType.informationUpdate:
        return const Icon(
          Icons.person_outline,
          size: 20,
        );
      case ActivityType.loanTransfer:
        return const Icon(
          Icons.sync,
          size: 20,
        );
      case ActivityType.inboundCall:
        return const Icon(
          Icons.phone_outlined,
          size: 20,
        );
    }
  }

  static Widget getActivityIconWithBackground(ActivityType type) {
    return Container(
      width: ActivityNotesTheme.iconSize,
      height: ActivityNotesTheme.iconSize,
      decoration: BoxDecoration(
        color: ActivityNotesTheme.iconBackground,
        borderRadius: BorderRadius.circular(ActivityNotesTheme.iconSize / 2),
      ),
      child: Center(
        child: getActivityIcon(type),
      ),
    );
  }
} 