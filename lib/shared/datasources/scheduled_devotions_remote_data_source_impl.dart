import 'dart:convert';
import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/constrants/scheduled_devotions_urls.dart';
import 'package:http/http.dart' as http;
import 'package:devotions_app/shared/models/scheduled_devotion.dart';
import 'package:devotions_app/shared/models/scheduled_devotion_create.dart';
import 'scheduled_devotions_remote_data_source.dart';

class ScheduledDevotionsRemoteDataSourceImpl
    implements ScheduledDevotionsRemoteDataSource {
  final http.Client client;

  ScheduledDevotionsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ScheduledDevotion>> getAllScheduledDevotions(
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(ScheduledDevotionsUrls.getAllScheduledDevotions);
    try {
      final response = await client.get(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map(
              (item) =>
                  ScheduledDevotion.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw ServerException(
          'Failed to get scheduled devotions: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<ScheduledDevotion> createScheduledDevotion(
    ScheduledDevotionCreate scheduledDevotion,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(ScheduledDevotionsUrls.createScheduledDevotion);
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'organisationId': organisationId,
          'branchId': branchId,
        },
        body: json.encode(scheduledDevotion.toJson()),
      );
      if (response.statusCode == 201) {
        return ScheduledDevotion.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to create scheduled devotion: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<ScheduledDevotion> getScheduledDevotionById(
    String id,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(ScheduledDevotionsUrls.getScheduledDevotionById(id));
    try {
      final response = await client.get(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
      if (response.statusCode == 200) {
        return ScheduledDevotion.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to get scheduled devotion $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<ScheduledDevotion> updateScheduledDevotion(
    String id,
    ScheduledDevotionCreate scheduledDevotion,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(ScheduledDevotionsUrls.updateScheduledDevotion(id));
    try {
      final response = await client.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'organisationId': organisationId,
          'branchId': branchId,
        },
        body: json.encode(scheduledDevotion.toJson()),
      );
      if (response.statusCode == 200) {
        return ScheduledDevotion.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to update scheduled devotion $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteScheduledDevotion(
    String id,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(ScheduledDevotionsUrls.deleteScheduledDevotion(id));
    try {
      final response = await client.delete(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
      if (response.statusCode != 204) {
        throw ServerException(
          'Failed to delete scheduled devotion $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<List<ScheduledDevotion>> getScheduledDevotionsByDate(
    String scheduledDate,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(
      ScheduledDevotionsUrls.getScheduledDevotionsByDate(scheduledDate),
    );
    try {
      final response = await client.get(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map(
              (item) =>
                  ScheduledDevotion.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw ServerException(
          'Failed to get scheduled devotions by date: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }
}
