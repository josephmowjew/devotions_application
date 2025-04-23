import 'package:intl/intl.dart';
import '../models/activity.dart';

class ActivityFormatter {
  static String formatTimestamp(DateTime timestamp) {
    return DateFormat('EEE MMM d @ h:mma').format(timestamp).replaceAll('AM', 'am').replaceAll('PM', 'pm');
  }

  static String getActivityTitle(Activity activity) {
    switch (activity.type) {
      case ActivityType.customerComplaint:
        return 'Customer complaint opened';
      case ActivityType.informationUpdate:
        return 'Updating customer information';
      case ActivityType.loanTransfer:
        return 'Loan transfer';
      case ActivityType.inboundCall:
        return 'Inbound Call by Customer';
    }
  }

  static String formatActivityTimestamp(Activity activity) {
    return '${formatTimestamp(activity.timestamp)} by ${activity.user}';
  }
} 