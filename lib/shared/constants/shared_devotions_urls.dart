class SharedDevotionsUrls {
  static const String _baseUrl = 'https://staging-devotion.lyvepulse.com/api';

  static String getAllSharedDevotions = '$_baseUrl/shared-devotions';
  static String createSharedDevotion = '$_baseUrl/shared-devotions';
  static String getSharedDevotionById(String id) =>
      '$_baseUrl/shared-devotions/$id';
  static String updateSharedDevotion(String id) =>
      '$_baseUrl/shared-devotions/$id';
  static String deleteSharedDevotion(String id) =>
      '$_baseUrl/shared-devotions/$id';
  static String getSharedDevotionsByUserId(String userId) =>
      '$_baseUrl/shared-devotions/user/$userId';
}
