class NoteTypeUrls {
  static const String _baseUrl = '/api';

  // List endpoint with organization context and pagination
  static String getAllNoteTypes =
      '$_baseUrl/note-types?organizationId={organizationId}&branchId={branchId}';

  // Single item endpoint
  static String getNoteType(String id) =>
      '$_baseUrl/note-types/$id?organizationId={organizationId}&branchId={branchId}';

  // Create endpoint
  static String createNoteType =
      '$_baseUrl/note-types?organizationId={organizationId}&branchId={branchId}';

  // Update endpoint
  static String updateNoteType(String id) =>
      '$_baseUrl/note-types/$id?organizationId={organizationId}&branchId={branchId}';

  // Delete endpoint
  static String deleteNoteType(String id) =>
      '$_baseUrl/note-types/$id?organizationId={organizationId}&branchId={branchId}';
}