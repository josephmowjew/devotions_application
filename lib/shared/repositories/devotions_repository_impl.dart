import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/datasources/devotions_remote_data_source.dart';
import 'package:devotions_app/shared/models/devotion.dart';
import 'package:devotions_app/shared/models/devotion_create.dart';
import 'package:devotions_app/shared/models/response.dart';
import 'devotions_repository.dart';

class DevotionsRepositoryImpl implements DevotionsRepository {
  final DevotionsRemoteDataSource remoteDataSource;

  DevotionsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Response>> getAllDevotions({
    String? date,
    String? search,
    required int page,
    required int pageSize,
    String? createdBy,
    required String organisationId,
    required String branchId,
  }) async {
    try {
      return await remoteDataSource.getAllDevotions(
        date: date,
        search: search,
        page: page,
        pageSize: pageSize,
        createdBy: createdBy,
        organisationId: organisationId,
        branchId: branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<Devotion> createDevotion(
    DevotionCreate devotion,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.createDevotion(
        devotion,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<Devotion> getDevotion(
    String id,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.getDevotionById(
        id,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<Devotion> updateDevotion(
    String id,
    Devotion devotion,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.updateDevotion(
        id,
        devotion,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<void> deleteDevotion(
    String id,
    String organisationId,
    String branchId,
  ) async {
    try {
      await remoteDataSource.deleteDevotion(id, organisationId, branchId);
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<Devotion>> getDevotionsByScheduledDate(
    String date,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.getDevotionsByScheduledDate(
        date,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }
}
