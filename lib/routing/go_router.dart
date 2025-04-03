import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devotions_app/pages/authentication/blocs/login/login_bloc.dart';
import 'package:devotions_app/routing/authentication_routes.dart';
import 'package:devotions_app/routing/main_routes.dart';
import 'package:devotions_app/shared/layouts/default_layout.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'main-shell');
  static final GoRouter _router = GoRouter(
    initialLocation: AuthRoutes.login,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ...AuthenticationRoutes.routes,
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        pageBuilder: (BuildContext context, GoRouterState state, Widget child) {
          return NoTransitionPage(
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginInitial) {
                  GoRouter.of(context).go(AuthRoutes.login);
                }
              },
              child: DefaultLayout(child: child),
            ),
          );
        },
        routes: [...MainRoutes.routes],
      ),
    ],
  );

  static GoRouter get router => _router;
}
