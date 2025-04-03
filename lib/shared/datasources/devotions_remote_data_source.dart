import 'package:devotions_app/shared/models/devotion.dart';
import 'package:devotions_app/shared/models/devotion_create.dart';
import 'package:devotions_app/shared/models/response.dart';

abstract class DevotionsRemoteDataSource {
  /// Get a list of all devotions
  /// Throws [ServerException] for API errors
  Future<List<Response>> getAllDevotions({
    String? date,
    String? search,
    required int page,
    required int pageSize,
    String? createdBy,
    required String organisationId,
    required String branchId,
  });

  /// Create a new devotion with the provided data
  /// Throws [ServerException] for API errors
  Future<Devotion> createDevotion(
    DevotionCreate devotion,
    String organisationId,
    String branchId,
  );

  /// Get a devotion by their ID
  /// Throws [ServerException] for API errors or if not found
  Future<Devotion> getDevotionById(
    String id,
    String organisationId,
    String branchId,
  );

  /// Update an existing devotion's information
  /// Throws [ServerException] for API errors
  Future<Devotion> updateDevotion(
    String id,
    Devotion devotion,
    String organisationId,
    String branchId,
  );

  /// Delete a devotion by their ID
  /// Throws [ServerException] for API errors
  Future<void> deleteDevotion(
    String id,
    String organisationId,
    String branchId,
  );

  /// Get a list of devotions scheduled for a specific date
  /// Throws [ServerException] for API errors
  Future<List<Devotion>> getDevotionsByScheduledDate(
    String date,
    String organisationId,
    String branchId,
  );
}
