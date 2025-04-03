import 'package:devotions_app/shared/models/authentication/auth_modals.dart';

abstract class AuthenticationProvider {
  Future<LoginResponse> loginUser(LoginDto login);
  Future<dynamic> saveToken(LoginResponse response);
  Future<String?> getToken();
  Future<LoginResponse> twoFactorCode(TwoFactorDto twoFactorDto);
  Future<String?> forgotPassword(String username);
  Future<String?> resetPassword(
    String token,
    ResetPasswordDto resetPasswordDto,
  );
  Future<String> changePassword(ChangePasswordDto changePasswordDto);
  Future<UserProfile> getUserProfile();
}
