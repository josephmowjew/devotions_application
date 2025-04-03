import 'dart:convert';
import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/constrants/shared_devotions_urls.dart';
import 'package:http/http.dart' as http;
import 'package:devotions_app/shared/models/shared_devotion.dart';
import 'package:devotions_app/shared/models/shared_devotion_create.dart';
import 'shared_devotions_remote_data_source.dart';

class SharedDevotionsRemoteDataSourceImpl
    implements SharedDevotionsRemoteDataSource {
  final http.Client client;

  SharedDevotionsRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SharedDevotion>> getAllSharedDevotions(
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(SharedDevotionsUrls.getAllSharedDevotions);
    try {
      final response = await client.get(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map(
              (item) => SharedDevotion.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw ServerException(
          'Failed to get shared devotions: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<SharedDevotion> createSharedDevotion(
    SharedDevotionCreate sharedDevotion,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(SharedDevotionsUrls.createSharedDevotion);
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'organisationId': organisationId,
          'branchId': branchId,
        },
        body: json.encode(sharedDevotion.toJson()),
      );
      if (response.statusCode == 201) {
        return SharedDevotion.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to create shared devotion: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<SharedDevotion> getSharedDevotionById(
    String id,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(SharedDevotionsUrls.getSharedDevotionById(id));
    try {
      final response = await client.get(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
      if (response.statusCode == 200) {
        return SharedDevotion.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to get shared devotion $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<SharedDevotion> updateSharedDevotion(
    String id,
    SharedDevotion sharedDevotion,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(SharedDevotionsUrls.updateSharedDevotion(id));
    try {
      final response = await client.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'organisationId': organisationId,
          'branchId': branchId,
        },
        body: json.encode(sharedDevotion.toJson()),
      );
      if (response.statusCode == 200) {
        return SharedDevotion.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to update shared devotion $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteSharedDevotion(
    String id,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(SharedDevotionsUrls.deleteSharedDevotion(id));
    try {
      final response = await client.delete(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
      if (response.statusCode != 204) {
        throw ServerException(
          'Failed to delete shared devotion $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<List<SharedDevotion>> getSharedDevotionsByUserId(
    String userId,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(
      SharedDevotionsUrls.getSharedDevotionsByUserId(userId),
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
              (item) => SharedDevotion.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw ServerException(
          'Failed to get shared devotions by user $userId: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }
}
