import 'dart:convert';
import 'package:devotions_app/shared/constants/note_type_urls.dart';
import 'package:devotions_app/shared/datasources/note_type_remote_data_source.dart';
import 'package:devotions_app/shared/models/note_type_create_dto.dart';
import 'package:devotions_app/shared/models/note_type_read_dto.dart';
import 'package:devotions_app/shared/models/note_type_update_dto.dart';
import 'package:devotions_app/shared/models/page_note_type_read_dto.dart';
import 'package:http/http.dart' as http;

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class NoteTypeRemoteDataSourceImpl implements NoteTypeRemoteDataSource {
  final http.Client client;
  static const String _baseUrl = 'https://staging-activity-notes.lyvepulse.com/activity-notes/api';

  NoteTypeRemoteDataSourceImpl(this.client);

  @override
  Future<PageNoteTypeReadDto> getAllNoteTypes({
    required int organizationId,
    required String branchId,
    int? page,
    int? pageSize,
    String? sortBy,
    String? sortDirection,
  }) async {
    try {
      final queryParams = {
        'organizationId': organizationId.toString(),
        'branchId': branchId,
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'pageSize': pageSize.toString(),
        if (sortBy != null) 'sortBy': sortBy,
        if (sortDirection != null) 'sortDirection': sortDirection,
      };

      final url = Uri.parse(
        '$_baseUrl${NoteTypeUrls.getAllNoteTypes
            .replaceAll('{organizationId}', organizationId.toString())
            .replaceAll('{branchId}', branchId)}',
      ).replace(queryParameters: queryParams);

      final response = await client.get(url);
      switch (response.statusCode) {
        case 200:
          final jsonData = json.decode(response.body);
          return PageNoteTypeReadDto.fromJson(jsonData as Map<String, dynamic>);
        case 404:
          throw ServerException('Note types not found');
        case 401:
          throw ServerException('Unauthorized');
        default:
          throw ServerException('Failed: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<NoteTypeReadDto> getNoteType(
    String id,
    String organizationId,
    String branchId,
  ) async {
    try {
      final queryParams = {
        'organizationId': organizationId,
        'branchId': branchId,
      };

      final url = Uri.parse(
        '$_baseUrl${NoteTypeUrls.getNoteType(id)
            .replaceAll('{organizationId}', organizationId)
            .replaceAll('{branchId}', branchId)}',
      ).replace(queryParameters: queryParams);

      final response = await client.get(url);
      switch (response.statusCode) {
        case 200:
          final jsonData = json.decode(response.body);
          return NoteTypeReadDto.fromJson(jsonData as Map<String, dynamic>);
        case 404:
          throw ServerException('Note type not found');
        case 401:
          throw ServerException('Unauthorized');
        default:
          throw ServerException('Failed: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<NoteTypeReadDto> createNoteType(
    NoteTypeCreateDto noteType,
    String organizationId,
    String branchId,
  ) async {
    try {
      final queryParams = {
        'organizationId': organizationId,
        'branchId': branchId,
      };

      final url = Uri.parse(
        '$_baseUrl${NoteTypeUrls.createNoteType
            .replaceAll('{organizationId}', organizationId)
            .replaceAll('{branchId}', branchId)}',
      ).replace(queryParameters: queryParams);

      final response = await client.post(
        url,
        body: json.encode(noteType.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      switch (response.statusCode) {
        case 200:
          final jsonData = json.decode(response.body);
          return NoteTypeReadDto.fromJson(jsonData as Map<String, dynamic>);
        case 400:
          throw ServerException('Invalid data: ${response.body}');
        default:
          throw ServerException('Failed: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<NoteTypeReadDto> updateNoteType(
    String id,
    NoteTypeUpdateDto noteType,
    String organizationId,
    String branchId,
  ) async {
    try {
      final queryParams = {
        'organizationId': organizationId,
        'branchId': branchId,
      };

      final url = Uri.parse(
        '$_baseUrl${NoteTypeUrls.updateNoteType(id)
            .replaceAll('{organizationId}', organizationId)
            .replaceAll('{branchId}', branchId)}',
      ).replace(queryParameters: queryParams);

      final response = await client.put(
        url,
        body: json.encode(noteType.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      switch (response.statusCode) {
        case 200:
          final jsonData = json.decode(response.body);
          return NoteTypeReadDto.fromJson(jsonData as Map<String, dynamic>);
        case 400:
          throw ServerException('Invalid data: ${response.body}');
        case 404:
          throw ServerException('Note type not found');
        default:
          throw ServerException('Failed: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteNoteType(
    String id,
    String organizationId,
    String branchId,
  ) async {
    try {
      final queryParams = {
        'organizationId': organizationId,
        'branchId': branchId,
      };

      final url = Uri.parse(
        '$_baseUrl${NoteTypeUrls.deleteNoteType(id)
            .replaceAll('{organizationId}', organizationId)
            .replaceAll('{branchId}', branchId)}',
      ).replace(queryParameters: queryParams);

      final response = await client.delete(url);
      switch (response.statusCode) {
        case 200:
          return;
        case 404:
          throw ServerException('Note type not found');
        case 401:
          throw ServerException('Unauthorized');
        default:
          throw ServerException('Failed: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Network error: ${e.toString()}');
    }
  }
}