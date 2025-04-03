import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/datasources/shared_devotions_remote_data_source.dart';
import 'package:devotions_app/shared/models/shared_devotion.dart';
import 'package:devotions_app/shared/models/shared_devotion_create.dart';
import 'shared_devotions_repository.dart';

class SharedDevotionsRepositoryImpl implements SharedDevotionsRepository {
  final SharedDevotionsRemoteDataSource remoteDataSource;

  SharedDevotionsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<SharedDevotion>> getAllSharedDevotions(
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.getAllSharedDevotions(
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<SharedDevotion> createSharedDevotion(
    SharedDevotionCreate sharedDevotion,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.createSharedDevotion(
        sharedDevotion,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<SharedDevotion> getSharedDevotion(
    String id,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.getSharedDevotionById(
        id,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<SharedDevotion> updateSharedDevotion(
    String id,
    SharedDevotion sharedDevotion,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.updateSharedDevotion(
        id,
        sharedDevotion,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<void> deleteSharedDevotion(
    String id,
    String organisationId,
    String branchId,
  ) async {
    try {
      await remoteDataSource.deleteSharedDevotion(id, organisationId, branchId);
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<SharedDevotion>> getSharedDevotionsByUserId(
    String userId,
    String organisationId,
    String branchId,
  ) async {
    try {
      return await remoteDataSource.getSharedDevotionsByUserId(
        userId,
        organisationId,
        branchId,
      );
    } on ServerException {
      rethrow;
    }
  }
}
