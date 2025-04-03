class DevotionsUrls {
  static const String _baseUrl = 'https://staging-devotion.lyvepulse.com/api';

  static String getAllDevotions({
    String? date,
    String? search,
    required int page,
    required int pageSize,
    String? createdBy,
  }) {
    final queryParams = {
      if (date != null) 'date': date,
      if (search != null) 'search': search,
      'page': page.toString(),
      'page_size': pageSize.toString(),
      if (createdBy != null) 'createdBy': createdBy,
    };
    return Uri.parse(
      '$_baseUrl/devotions',
    ).replace(queryParameters: queryParams).toString();
  }

  static String createDevotion = '$_baseUrl/devotions';
  static String getDevotionById(String id) => '$_baseUrl/devotions/$id';
  static String updateDevotion(String id) => '$_baseUrl/devotions/$id';
  static String deleteDevotion(String id) => '$_baseUrl/devotions/$id';
  static String getDevotionsByScheduledDate(String date) =>
      '$_baseUrl/devotions/scheduled-date?date=$date';
}
