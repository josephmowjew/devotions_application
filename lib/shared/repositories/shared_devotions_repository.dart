import 'package:devotions_app/shared/models/shared_devotion.dart';
import 'package:devotions_app/shared/models/shared_devotion_create.dart';

abstract class SharedDevotionsRepository {
  Future<List<SharedDevotion>> getAllSharedDevotions(
    String organisationId,
    String branchId,
  );
  Future<SharedDevotion> createSharedDevotion(
    SharedDevotionCreate sharedDevotion,
    String organisationId,
    String branchId,
  );
  Future<SharedDevotion> getSharedDevotion(
    String id,
    String organisationId,
    String branchId,
  );
  Future<SharedDevotion> updateSharedDevotion(
    String id,
    SharedDevotion sharedDevotion,
    String organisationId,
    String branchId,
  );
  Future<void> deleteSharedDevotion(
    String id,
    String organisationId,
    String branchId,
  );
  Future<List<SharedDevotion>> getSharedDevotionsByUserId(
    String userId,
    String organisationId,
    String branchId,
  );
}
