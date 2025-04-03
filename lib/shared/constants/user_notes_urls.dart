class UserNotesUrls {
  static const String _baseUrl = 'https://staging-devotion.lyvepulse.com/api';

  static String getAllUserNotes = '$_baseUrl/user-notes';
  static String getAllUsers = '$_baseUrl/users';
  static String createUserNote = '$_baseUrl/user-notes';
  static String getUserNoteById(String id) => '$_baseUrl/user-notes/$id';
  static String updateUserNote(String id) => '$_baseUrl/user-notes/$id';
  static String deleteUserNote(String id) => '$_baseUrl/user-notes/$id';
  static String getUserNotesByDevotionId(String devotionId) =>
      '$_baseUrl/user-notes/devotion/$devotionId';
}
