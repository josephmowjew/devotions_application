import 'dart:convert';
import 'package:devotions_app/shared/constants/activity_note_urls.dart';
import 'package:devotions_app/shared/datasources/activity_note_remote_data_source.dart';
import 'package:devotions_app/shared/models/activity_note_create_dto.dart';
import 'package:devotions_app/shared/models/activity_note_filter_dto.dart';
import 'package:devotions_app/shared/models/activity_note_read_dto.dart';
import 'package:devotions_app/shared/models/activity_note_update_dto.dart';
import 'package:devotions_app/shared/models/paginated_activity_note_response.dart';
import 'package:devotions_app/shared/utils/http_utils.dart';
import 'package:http/http.dart' as http;

class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class ActivityNoteRemoteDataSourceImpl implements ActivityNoteRemoteDataSource {
  final http.Client client;
  static const String _baseUrl = 'https://staging-activity-notes.lyvepulse.com';

  ActivityNoteRemoteDataSourceImpl(this.client);

  @override
  Future<PaginatedActivityNoteResponse> getAllActivityNotes({
    required int organizationId,
    required String branchId,
    int? page,
    int? pageSize,
    String? creatorEmail,
    List<String>? entityType,
    List<String>? entityId,
    List<String>? noteType,
    List<String>? creatorType,
    String? startDate,
    String? endDate,
    String? searchKeyword,
  }) async {
    try {
      final Map<String, String> queryParams = {
        'organizationId': organizationId.toString(),
        'branchId': branchId,
        if (page != null) 'page': page.toString(),
        if (pageSize != null) 'pageSize': pageSize.toString(),
        if (creatorEmail != null) 'creatorEmail': creatorEmail,
        if (entityType != null) 'entityType': entityType.join(','),
        if (entityId != null) 'entityId': entityId.join(','),
        if (noteType != null) 'noteType': noteType.join(','),
        if (creatorType != null) 'creatorType': creatorType.join(','),
        if (startDate != null) 'startDate': startDate,
        if (endDate != null) 'endDate': endDate,
        if (searchKeyword != null) 'searchKeyword': searchKeyword,
      };

      final url = Uri.parse(
        '$_baseUrl${ActivityNoteUrls.getAllActivityNotes}',
      ).replace(queryParameters: queryParams);

      final response = await HttpUtils.get(url, client);
      switch (response.statusCode) {
        case 200:
          final jsonData = json.decode(response.body);
          return PaginatedActivityNoteResponse.fromJson(jsonData as Map<String, dynamic>);
        case 404:
          throw ServerException('Activity notes not found');
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
  Future<ActivityNoteReadDto> getActivityNote(
    String id,
    String organizationId,
    String branchId,
  ) async {
    try {
      final Map<String, String> queryParams = {
        'organizationId': organizationId,
        'branchId': branchId,
      };

      final url = Uri.parse(
        '$_baseUrl${ActivityNoteUrls.getActivityNote(id)}',
      ).replace(queryParameters: queryParams);

      final response = await HttpUtils.get(url, client);
      switch (response.statusCode) {
        case 200:
          final jsonData = json.decode(response.body);
          return ActivityNoteReadDto.fromJson(jsonData as Map<String, dynamic>);
        case 404:
          throw ServerException('Activity note not found');
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
  Future<ActivityNoteReadDto> createActivityNote(
    ActivityNoteCreateDto activityNote,
    String organizationId,
    String branchId,
  ) async {
    try {
      final Map<String, String> queryParams = {
        'organizationId': organizationId,
        'branchId': branchId,
      };

      final url = Uri.parse(
        '$_baseUrl${ActivityNoteUrls.createActivityNote}',
      ).replace(queryParameters: queryParams);

      final response = await HttpUtils.post(
        url,
        client,
        body: activityNote.toJson(),
      );

      switch (response.statusCode) {
        case 200:
          final jsonData = json.decode(response.body);
          return ActivityNoteReadDto.fromJson(jsonData['activityNote'] as Map<String, dynamic>);
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
  Future<ActivityNoteReadDto> updateActivityNote(
    String id,
    ActivityNoteUpdateDto activityNote,
    String organizationId,
    String branchId,
  ) async {
    try {
      final Map<String, String> queryParams = {
        'organizationId': organizationId,
        'branchId': branchId,
      };

      final url = Uri.parse(
        '$_baseUrl${ActivityNoteUrls.updateActivityNote(id)}',
      ).replace(queryParameters: queryParams);

      final response = await HttpUtils.put(
        url,
        client,
        body: activityNote.toJson(),
      );

      switch (response.statusCode) {
        case 200:
          final jsonData = json.decode(response.body);
          return ActivityNoteReadDto.fromJson(jsonData as Map<String, dynamic>);
        case 400:
          throw ServerException('Invalid data: ${response.body}');
        case 404:
          throw ServerException('Activity note not found');
        default:
          throw ServerException('Failed: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Network error: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteActivityNote(
    String id,
    String organizationId,
    String branchId,
  ) async {
    try {
      final Map<String, String> queryParams = {
        'organizationId': organizationId,
        'branchId': branchId,
      };

      final url = Uri.parse(
        '$_baseUrl${ActivityNoteUrls.deleteActivityNote(id)}',
      ).replace(queryParameters: queryParams);

      final response = await HttpUtils.delete(url, client);
      switch (response.statusCode) {
        case 200:
          return;
        case 404:
          throw ServerException('Activity note not found');
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
  Future<PaginatedActivityNoteResponse> filterActivityNotes(
    ActivityNoteFilterDto filter,
  ) async {
    try {
      final url = Uri.parse('$_baseUrl${ActivityNoteUrls.filterActivityNotes}');

      final response = await HttpUtils.post(
        url,
        client,
        body: filter.toJson(),
      );

      switch (response.statusCode) {
        case 200:
          final jsonData = json.decode(response.body);
          return PaginatedActivityNoteResponse.fromJson(jsonData as Map<String, dynamic>);
        case 400:
          throw ServerException('Invalid filter data: ${response.body}');
        default:
          throw ServerException('Failed: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Network error: ${e.toString()}');
    }
  }
}