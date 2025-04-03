import 'package:devotions_app/pages/authentication/components/views/forgot_password/forgot_password.dart';
import 'package:devotions_app/pages/authentication/components/views/forgot_password/forgot_password_success.dart';
import 'package:devotions_app/pages/authentication/components/views/login/login_page.dart';
import 'package:devotions_app/pages/authentication/components/views/reset_password/reset_password.dart';
import 'package:devotions_app/pages/authentication/components/views/two_factor/two_factor.dart';
import 'package:go_router/go_router.dart';

class AuthRoutes {
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/recovery';
  static const String twofactorAuth = '/two-factor-auth';
  static const String resetSuccess = '/reset-success';
  static const String splash = '/splash';
}

class AuthenticationRoutes {
  static List<GoRoute> routes = [
    // GoRoute(
    //   path: AuthRoutes.splash,
    //   pageBuilder: (context, state) =>
    //       const NoTransitionPage(child: SplashScreen()),
    // ),
    GoRoute(
      path: AuthRoutes.login,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: LoginPage()),
    ),
    GoRoute(
      path: AuthRoutes.forgotPassword,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: ForgotPassword()),
    ),
    GoRoute(
      path: AuthRoutes.resetPassword,
      pageBuilder: (context, state) {
        final token = state.uri.queryParameters['reset_token'];
        // if (token == null) {
        //       return NoTransitionPage(child:  LoginPage());

        // }
        return NoTransitionPage(child: ResetPassword(token: token));
      },
    ),
    GoRoute(
      path: AuthRoutes.twofactorAuth,
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: TwoFactor()),
    ),
    GoRoute(
      path: AuthRoutes.resetSuccess,
      pageBuilder: (context, state) {
        final email = (state.extra as Map<String, dynamic>)['email'] as String;

        return NoTransitionPage(
            child: ForgotPasswordSuccess(
          email: email,
        ));
      },
    ),
  ];
}
