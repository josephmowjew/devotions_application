import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/datasources/user_notes_remote_data_source.dart';
import 'package:devotions_app/shared/models/user_note.dart';
import 'package:devotions_app/shared/models/user_note_create.dart';
import 'user_notes_repository.dart';

class UserNotesRepositoryImpl implements UserNotesRepository {
  final UserNotesRemoteDataSource remoteDataSource;

  UserNotesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<UserNote>> getAllUserNotes(
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.getAllUserNotes(organisationId, branchId);
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<UserNote> createUserNote(
    UserNoteCreate userNote,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.createUserNote(
        userNote,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<UserNote> getUserNote(
    String id,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.getUserNoteById(
        id,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<UserNote> updateUserNote(
    String id,
    UserNoteCreate userNote,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.updateUserNote(
        id,
        userNote,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<void> deleteUserNote(String id) async {
    try {
      await remoteDataSource.deleteUserNote(id);
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<UserNote>> getUserNotesByDevotionId(String devotionId) async {
    try {
      return await remoteDataSource.getUserNotesByDevotionId(devotionId);
    } on ServerException {
      rethrow;
    }
  }
}
