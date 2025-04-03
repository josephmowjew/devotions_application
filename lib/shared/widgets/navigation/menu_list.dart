import 'package:flutter/material.dart';
import 'package:devotions_app/routing/main_routes.dart';
import 'package:lyvepulse_components/components/navbar/menu_item.dart';

List<MenuItem> mainMenuItems = [
  const MenuItem(
    icon: Icons.menu_book,
    title: "Devotions",
    route: AppRoutes.devotions,
  ),
  // These menu items will be uncommented when the pages are created
  /*
  const MenuItem(
    icon: Icons.home,
    title: "Home",
    route: AppRoutes.home,
  ),
  const MenuItem(
    icon: Icons.list_alt_rounded,
    title: "Prayer Activities",
    route: AppRoutes.prayerActivities,
  ),
  const MenuItem(
    icon: Icons.account_circle_outlined,
    title: "Profile",
    route: AppRoutes.profile,
  ),
  */
];
