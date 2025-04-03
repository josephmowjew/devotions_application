import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/datasources/favorites_remote_data_source.dart';
import 'package:devotions_app/shared/models/favorite.dart';
import 'package:devotions_app/shared/models/favorite_create.dart';
import 'favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final FavoritesRemoteDataSource remoteDataSource;

  FavoritesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Favorite>> getAllFavorites(
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.getAllFavorites(organisationId, branchId);
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<Favorite> createFavorite(
    FavoriteCreate favorite,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.createFavorite(
        favorite,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<Favorite> getFavorite(
    String id,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.getFavoriteById(
        id,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<Favorite> updateFavorite(
    String id,
    FavoriteCreate favorite,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.updateFavorite(
        id,
        favorite,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<void> deleteFavorite(
    String id,
    String organisationId,
    String branchId,
  ) async {
    try {
      await remoteDataSource.deleteFavorite(id, organisationId, branchId);
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Favorite>> getFavoritesByUserId(
    String userId,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.getFavoritesByUserId(
        userId,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }
}
