import 'package:devotions_app/shared/models/scheduled_devotion.dart';
import 'package:devotions_app/shared/models/scheduled_devotion_create.dart';

abstract class ScheduledDevotionsRemoteDataSource {
  Future<List<ScheduledDevotion>> getAllScheduledDevotions(
    String organisationId,
    String branchId,
  );
  Future<ScheduledDevotion> createScheduledDevotion(
    ScheduledDevotionCreate scheduledDevotion,
    String organisationId,
    String branchId,
  );
  Future<ScheduledDevotion> getScheduledDevotionById(
    String id,
    String organisationId,
    String branchId,
  );
  Future<ScheduledDevotion> updateScheduledDevotion(
    String id,
    ScheduledDevotionCreate scheduledDevotion,
    String organisationId,
    String branchId,
  );
  Future<void> deleteScheduledDevotion(
    String id,
    String organisationId,
    String branchId,
  );
  Future<List<ScheduledDevotion>> getScheduledDevotionsByDate(
    String scheduledDate,
    String organisationId,
    String branchId,
  );
}
