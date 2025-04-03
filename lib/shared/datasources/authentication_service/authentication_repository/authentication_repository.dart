import 'package:dartz/dartz.dart';
import 'package:devotions_app/shared/models/authentication/auth_modals.dart';
import 'package:devotions_app/core/errors/errors_exports.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, LoginResponse?>> loginUser(LoginDto loginDto);
  Future<Either<Failure, dynamic>> saveToken(LoginResponse reponse);
  Future<Either<Failure, String>> getToken();
  Future<Either<Failure, LoginResponse?>> twoFactorCode(
    TwoFactorDto twoFactorDto,
  );
  Future<Either<Failure, dynamic>> forgotPassword(String username);
  Future<Either<Failure, dynamic>> resetPassword(
    String token,
    ResetPasswordDto resetPasswordDto,
  );

  Future<Either<Failure, dynamic>> changePassword(
    ChangePasswordDto changePasswordDto,
  );
  Future<Either<Failure, UserProfile>> getUserProfile();
}
