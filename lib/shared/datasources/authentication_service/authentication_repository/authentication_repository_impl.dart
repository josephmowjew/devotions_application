import 'package:dartz/dartz.dart';
import 'package:devotions_app/shared/models/authentication/auth_modals.dart';
import 'package:devotions_app/core/errors/errors_exports.dart';
import 'package:devotions_app/shared/datasources/authentication_service/authentication_service.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationProvider provider;

  AuthenticationRepositoryImpl({required this.provider});

  @override
  Future<Either<Failure, LoginResponse?>> loginUser(LoginDto loginDto) async {
    try {
      final ticket = await provider.loginUser(loginDto);
      return Right(ticket);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.message));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> getToken() async {
    try {
      final token = await provider.getToken();
      return Right(token ?? '');
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> saveToken(LoginResponse response) async {
    try {
      final tokenResponse = await provider.saveToken(response);
      return Right(tokenResponse);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> changePassword(
    ChangePasswordDto changePasswordDto,
  ) async {
    try {
      final data = await provider.changePassword(changePasswordDto);
      return Right(data);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.message));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> forgotPassword(String username) async {
    try {
      final data = await provider.forgotPassword(username);
      return Right(data);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.message));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> resetPassword(
    String token,
    ResetPasswordDto resetPasswordDto,
  ) async {
    try {
      final data = await provider.resetPassword(token, resetPasswordDto);
      return Right(data);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.message));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginResponse?>> twoFactorCode(
    TwoFactorDto twoFactorDto,
  ) async {
    try {
      final data = await provider.twoFactorCode(twoFactorDto);
      return Right(data);
    } catch (e) {
      if (e is ServerException) {
        return Left(ServerFailure(e.message));
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> getUserProfile() async {
    try {
      final data = await provider.getUserProfile();
      return Right(data);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
