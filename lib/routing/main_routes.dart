import 'package:flutter/material.dart';
import 'package:devotions_app/pages/devotions/devotions_page.dart';
import 'package:devotions_app/shared/layouts/default_layout.dart';
// These imports will be uncommented when the files are created
// import 'package:devotions_app/pages/home/home.dart';
// import 'package:devotions_app/pages/prayer_activities/prayer_activities.dart';
// import 'package:devotions_app/pages/profile/profile.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String devotions = '/devotions';
  // These will be uncommented when the pages are created
  // static const String home = '/home';
  // static const String prayerActivities = '/prayer_activities';
  // static const String profile = '/profile';

  // Default route that will be used after login
  static const String initial = devotions;
}

class MainRoutes {
  static List<GoRoute> routes = [
    GoRoute(
      path: AppRoutes.devotions,
      pageBuilder:
          (context, state) => NoTransitionPage(
            child: DefaultLayout(
              child: PopScope(canPop: false, child: DevotionsPage()),
            ),
          ),
      routes: const [],
    ),
    // These routes will be uncommented when the pages are created
    /*
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: PopScope(canPop: false, child: HomePage()),
      ),
      routes: [
        GoRoute(
          path: 'devotion',
          pageBuilder: (context, state) {
            String day = '';
            if (state.extra != null) {
              day = (state.extra as Map<String, dynamic>)['day'] as String;
            }
            return NoTransitionPage(
              child: PopScope(canPop: false, child: DevotionPage(day: day)),
            );
          },
          routes: const [],
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.prayerActivities,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: PopScope(canPop: false, child: PrayerActivitiesPage()),
      ),
      routes: const [],
    ),
    GoRoute(
      path: AppRoutes.profile,
      pageBuilder: (context, state) => const NoTransitionPage(
        child: PopScope(canPop: false, child: ProfilePage()),
      ),
      routes: const [],
    ),
    */
  ];
}
