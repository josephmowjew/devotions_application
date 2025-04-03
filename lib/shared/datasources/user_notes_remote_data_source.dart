import 'package:devotions_app/shared/models/user_note.dart';
import 'package:devotions_app/shared/models/user_note_create.dart';

abstract class UserNotesRemoteDataSource {
  Future<List<UserNote>> getAllUserNotes(
    String organisationId,
    String branchId,
  );
  Future<UserNote> createUserNote(
    UserNoteCreate userNote,
    String organisationId,
    String branchId,
  );
  Future<UserNote> getUserNoteById(
    String id,
    String organisationId,
    String branchId,
  );
  Future<UserNote> updateUserNote(
    String id,
    UserNoteCreate userNote,
    String organisationId,
    String branchId,
  );
  Future<void> deleteUserNote(String id);
  Future<List<UserNote>> getUserNotesByDevotionId(String devotionId);
}
