import 'package:devotions_app/shared/models/devotion.dart';
import 'package:devotions_app/shared/models/devotion_create.dart';
import 'package:devotions_app/shared/models/response.dart';

abstract class DevotionsRepository {
  Future<List<Response>> getAllDevotions({
    String? date,
    String? search,
    required int page,
    required int pageSize,
    String? createdBy,
    required String organisationId,
    required String branchId,
  });
  Future<Devotion> createDevotion(
    DevotionCreate devotion,
    String organisationId,
    String branchId,
  );
  Future<Devotion> getDevotion(
    String id,
    String organisationId,
    String branchId,
  );
  Future<Devotion> updateDevotion(
    String id,
    Devotion devotion,
    String organisationId,
    String branchId,
  );
  Future<void> deleteDevotion(
    String id,
    String organisationId,
    String branchId,
  );
  Future<List<Devotion>> getDevotionsByScheduledDate(
    String date,
    String organisationId,
    String branchId,
  );
}
