class ScheduledDevotionsUrls {
  static const String _baseUrl = 'https://staging-devotion.lyvepulse.com/api';

  static String getAllScheduledDevotions = '$_baseUrl/scheduled-devotions';
  static String createScheduledDevotion = '$_baseUrl/scheduled-devotions';
  static String getScheduledDevotionById(String id) =>
      '$_baseUrl/scheduled-devotions/$id';
  static String updateScheduledDevotion(String id) =>
      '$_baseUrl/scheduled-devotions/$id';
  static String deleteScheduledDevotion(String id) =>
      '$_baseUrl/scheduled-devotions/$id';
  static String getScheduledDevotionsByDate(String scheduledDate) =>
      '$_baseUrl/scheduled-devotions/scheduled-date/$scheduledDate';
}
