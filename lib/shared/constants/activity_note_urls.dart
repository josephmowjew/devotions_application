class ActivityNoteUrls {
  static const String _baseUrl = '/activity-notes/api';

  // List endpoint with organization context and filters
  static String getAllActivityNotes =
      '$_baseUrl/activity-notes';

  // Single item endpoint
  static String getActivityNote(String id) =>
      '$_baseUrl/activity-notes/$id';

  // Create endpoint
  static String createActivityNote =
      '$_baseUrl/activity-notes';

  // Update endpoint
  static String updateActivityNote(String id) =>
      '$_baseUrl/activity-notes/$id';

  // Delete endpoint
  static String deleteActivityNote(String id) =>
      '$_baseUrl/activity-notes/$id';

  // Filter endpoint
  static String filterActivityNotes = '$_baseUrl/activity-notes/filter';
}