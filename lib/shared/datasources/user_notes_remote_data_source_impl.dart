import 'dart:convert';
import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/constrants/user_notes_urls.dart';
import 'package:http/http.dart' as http;
import 'package:devotions_app/shared/models/user_note.dart';
import 'package:devotions_app/shared/models/user_note_create.dart';
import 'user_notes_remote_data_source.dart';

class UserNotesRemoteDataSourceImpl implements UserNotesRemoteDataSource {
  final http.Client client;

  UserNotesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserNote>> getAllUserNotes(
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(UserNotesUrls.getAllUserNotes);
    try {
      final response = await client.get(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map((item) => UserNote.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          'Failed to get user notes: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<UserNote> createUserNote(
    UserNoteCreate userNote,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(UserNotesUrls.createUserNote);
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'organisationId': organisationId,
          'branchId': branchId,
        },
        body: json.encode(userNote.toJson()),
      );
      if (response.statusCode == 201) {
        return UserNote.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to create user note: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<UserNote> getUserNoteById(
    String id,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(UserNotesUrls.getUserNoteById(id));
    try {
      final response = await client.get(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
      if (response.statusCode == 200) {
        return UserNote.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to get user note $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<UserNote> updateUserNote(
    String id,
    UserNoteCreate userNote,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(UserNotesUrls.updateUserNote(id));
    try {
      final response = await client.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'organisationId': organisationId,
          'branchId': branchId,
        },
        body: json.encode(userNote.toJson()),
      );
      if (response.statusCode == 200) {
        return UserNote.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to update user note $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteUserNote(String id) async {
    final url = Uri.parse(UserNotesUrls.deleteUserNote(id));
    try {
      final response = await client.delete(url);
      if (response.statusCode != 204) {
        throw ServerException(
          'Failed to delete user note $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<List<UserNote>> getUserNotesByDevotionId(String devotionId) async {
    final url = Uri.parse(UserNotesUrls.getUserNotesByDevotionId(devotionId));
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map((item) => UserNote.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          'Failed to get user notes by devotion $devotionId: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }
}
