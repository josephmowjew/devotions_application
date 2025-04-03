import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/datasources/scheduled_devotions_remote_data_source.dart';
import 'package:devotions_app/shared/models/scheduled_devotion.dart';
import 'package:devotions_app/shared/models/scheduled_devotion_create.dart';
import 'scheduled_devotions_repository.dart';

class ScheduledDevotionsRepositoryImpl implements ScheduledDevotionsRepository {
  final ScheduledDevotionsRemoteDataSource remoteDataSource;

  ScheduledDevotionsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ScheduledDevotion>> getAllScheduledDevotions(
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.getAllScheduledDevotions(
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<ScheduledDevotion> createScheduledDevotion(
    ScheduledDevotionCreate scheduledDevotion,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.createScheduledDevotion(
        scheduledDevotion,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<ScheduledDevotion> getScheduledDevotion(
    String id,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.getScheduledDevotionById(
        id,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<ScheduledDevotion> updateScheduledDevotion(
    String id,
    ScheduledDevotionCreate scheduledDevotion,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.updateScheduledDevotion(
        id,
        scheduledDevotion,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<void> deleteScheduledDevotion(
    String id,
    String organisationId,
    String branchId,
  ) async {
    try {
      await remoteDataSource.deleteScheduledDevotion(
        id,
        organisationId,
        branchId,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ScheduledDevotion>> getScheduledDevotionsByDate(
    String scheduledDate,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.getScheduledDevotionsByDate(
        scheduledDate,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }
}
