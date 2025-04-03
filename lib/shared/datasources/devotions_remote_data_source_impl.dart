import 'dart:convert';
import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/constants/devotions_urls.dart';
import 'package:devotions_app/shared/utils/http_utils.dart';
import 'package:http/http.dart' as http;
import 'package:devotions_app/shared/models/devotion.dart';
import 'package:devotions_app/shared/models/devotion_create.dart';
import 'package:devotions_app/shared/models/response.dart';
import 'devotions_remote_data_source.dart';

class DevotionsRemoteDataSourceImpl implements DevotionsRemoteDataSource {
  final http.Client client;

  DevotionsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Response>> getAllDevotions({
    String? date,
    String? search,
    required int page,
    required int pageSize,
    String? createdBy,
    required String organisationId,
    required String branchId,
  }) async {
    final url = DevotionsUrls.getAllDevotions(
      date: date,
      search: search,
      page: page,
      pageSize: pageSize,
      createdBy: createdBy,
    );
    try {
      final response = await HttpUtils.get(Uri.parse(url), client);

      if (response.statusCode == 200) {
        final dynamic decodedData = json.decode(response.body);

        if (decodedData is Map<String, dynamic>) {
          // Handle single response object case
          return [Response.fromJson(decodedData)];
        } else if (decodedData is List) {
          // Handle list of responses case
          return decodedData
              .map((item) => Response.fromJson(item as Map<String, dynamic>))
              .toList();
        } else {
          throw ServerException(
            'Unexpected response format: ${decodedData.runtimeType}',
          );
        }
      } else {
        throw ServerException(
          'Failed to get devotions: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<Devotion> createDevotion(
    DevotionCreate devotion,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(DevotionsUrls.createDevotion);
    try {
      final response = await HttpUtils.post(
        url,
        client,
        body: devotion.toJson(),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 201) {
        return Devotion.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to create devotion: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<Devotion> getDevotionById(
    String id,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(DevotionsUrls.getDevotionById(id));
    try {
      final response = await HttpUtils.get(url, client);

      if (response.statusCode == 200) {
        return Devotion.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to get devotion $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<Devotion> updateDevotion(
    String id,
    Devotion devotion,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(DevotionsUrls.updateDevotion(id));
    try {
      final response = await HttpUtils.put(
        url,
        client,
        body: devotion.toJson(),
      );

      if (response.statusCode == 200) {
        return Devotion.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to update devotion $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteDevotion(
    String id,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(DevotionsUrls.deleteDevotion(id));
    try {
      final response = await HttpUtils.delete(url, client);

      if (response.statusCode != 204) {
        throw ServerException(
          'Failed to delete devotion $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<List<Devotion>> getDevotionsByScheduledDate(
    String date,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(DevotionsUrls.getDevotionsByScheduledDate(date));
    try {
      final response = await HttpUtils.get(url, client);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map((item) => Devotion.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          'Failed to get devotions by date: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }
}
