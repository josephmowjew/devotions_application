import 'package:devotions_app/shared/models/favorite.dart';
import 'package:devotions_app/shared/models/favorite_create.dart';

abstract class FavoritesRepository {
  Future<List<Favorite>> getAllFavorites(
    String organisationId,
    String branchId,
  );
  Future<Favorite> createFavorite(
    FavoriteCreate favorite,
    String organisationId,
    String branchId,
  );
  Future<Favorite> getFavorite(
    String id,
    String organisationId,
    String branchId,
  );
  Future<Favorite> updateFavorite(
    String id,
    FavoriteCreate favorite,
    String organisationId,
    String branchId,
  );
  Future<void> deleteFavorite(
    String id,
    String organisationId,
    String branchId,
  );
  Future<List<Favorite>> getFavoritesByUserId(
    String userId,
    String organisationId,
    String branchId,
  );
}
