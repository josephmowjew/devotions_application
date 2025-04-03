class FavoritesUrls {
  static const String _baseUrl = 'https://staging-devotion.lyvepulse.com/api';

  static String getAllFavorites = '$_baseUrl/favorites';
  static String createFavorite = '$_baseUrl/favorites';
  static String getFavoriteById(String id) => '$_baseUrl/favorites/$id';
  static String updateFavorite(String id) => '$_baseUrl/favorites/$id';
  static String deleteFavorite(String id) => '$_baseUrl/favorites/$id';
  static String getFavoritesByUserId(String userId) =>
      '$_baseUrl/favorites/user/$userId';
}
