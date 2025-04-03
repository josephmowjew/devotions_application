import 'dart:convert';
import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/constrants/devotions_urls.dart';
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
      final response = await client.get(
        Uri.parse(url),
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map((item) => Response.fromJson(item as Map<String, dynamic>))
            .toList();
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
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'organisationId': organisationId,
          'branchId': branchId,
        },
        body: json.encode(devotion.toJson()),
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
      final response = await client.get(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
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
      final response = await client.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'organisationId': organisationId,
          'branchId': branchId,
        },
        body: json.encode(devotion.toJson()),
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
      final response = await client.delete(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
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
      final response = await client.get(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
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
