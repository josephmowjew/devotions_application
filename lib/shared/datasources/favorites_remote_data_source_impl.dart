import 'dart:convert';
import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/constrants/favorites_urls.dart';
import 'package:http/http.dart' as http;
import 'package:devotions_app/shared/models/favorite.dart';
import 'package:devotions_app/shared/models/favorite_create.dart';
import 'favorites_remote_data_source.dart';

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final http.Client client;

  FavoritesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<Favorite>> getAllFavorites(
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(FavoritesUrls.getAllFavorites);
    try {
      final response = await client.get(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map((item) => Favorite.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          'Failed to get favorites: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<Favorite> createFavorite(
    FavoriteCreate favorite,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(FavoritesUrls.createFavorite);
    try {
      final response = await client.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'organisationId': organisationId,
          'branchId': branchId,
        },
        body: json.encode(favorite.toJson()),
      );
      if (response.statusCode == 201) {
        return Favorite.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to create favorite: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<Favorite> getFavoriteById(
    String id,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(FavoritesUrls.getFavoriteById(id));
    try {
      final response = await client.get(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
      if (response.statusCode == 200) {
        return Favorite.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to get favorite $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<Favorite> updateFavorite(
    String id,
    FavoriteCreate favorite,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(FavoritesUrls.updateFavorite(id));
    try {
      final response = await client.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'organisationId': organisationId,
          'branchId': branchId,
        },
        body: json.encode(favorite.toJson()),
      );
      if (response.statusCode == 200) {
        return Favorite.fromJson(json.decode(response.body));
      } else {
        throw ServerException(
          'Failed to update favorite $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteFavorite(
    String id,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(FavoritesUrls.deleteFavorite(id));
    try {
      final response = await client.delete(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
      if (response.statusCode != 204) {
        throw ServerException(
          'Failed to delete favorite $id: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }

  @override
  Future<List<Favorite>> getFavoritesByUserId(
    String userId,
    String organisationId,
    String branchId,
  ) async {
    final url = Uri.parse(FavoritesUrls.getFavoritesByUserId(userId));
    try {
      final response = await client.get(
        url,
        headers: {'organisationId': organisationId, 'branchId': branchId},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data
            .map((item) => Favorite.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw ServerException(
          'Failed to get favorites by user $userId: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw ServerException('Network or parsing error: ${e.toString()}');
    }
  }
}
