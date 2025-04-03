import 'package:devotions_app/shared/environments/environment_urls.dart';

class AuthenticationUrls {
  static final String _baseUrl = EnvironmentUrls().permissionsService;
  static String login = '$_baseUrl/authenticate/login';
  static String twoFactor = '$_baseUrl/authenticate/verify';

  static String forgotPasswod =
      '$_baseUrl/authenticate/forgot/credentials?username=';
  static String restPassword = '$_baseUrl/authenticate/reset-password';

  static String changePassword = '$_baseUrl/users/self/update/credentials';

  static String getUserProfile = '$_baseUrl/users/self/view';
}
