import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devotions_app/shared/widgets/navigation/nav_bar_item_widget.dart';
import 'package:go_router/go_router.dart';

// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:lyvepulse_components/components/navbar/bloc/navbar_cubit.dart';
import 'package:lyvepulse_components/components/navbar/bloc/navbar_state.dart';
import 'package:lyvepulse_components/components/navbar/menu_item.dart';
import 'package:lyvepulse_components/utils/constants/spacing.dart';

class NavigationMenuList extends StatefulWidget {
  final StatefulNavigationShell? navigationShell;
  final bool isBottomNav;
  const NavigationMenuList({
    super.key,
    this.navigationShell,
    required this.isBottomNav,
  });

  @override
  State<NavigationMenuList> createState() => _NavigationMenuListState();
}

class _NavigationMenuListState extends State<NavigationMenuList> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final identifier = context.read<CustomerDetailCubit>().state;
      // updateMenuFromRoute(
      //   context,
      //   '${identifier.id}',
      //   MediaQuery.of(context).size.width * .75,
      // );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log('Is Mobile ${widget.isBottomNav}');
    return LayoutBuilder(
      builder: (context, constraints) {
        context.watch<NavbarCubit>().updateVisibleItems(
          constraints.maxWidth * .75,
          isMobile: widget.isBottomNav,
        );
        // log('Route is ${cubit.state.selectedItem}');
        return Center(
          child: SizedBox(
            width:
                widget.isBottomNav
                    ? MediaQuery.of(context).size.width
                    : MediaQuery.of(context).size.width * .8,
            height:
                !widget.isBottomNav
                    ? 46
                    : 78, // Set desired height for the menu
            child: BlocBuilder<NavbarCubit, NavbarState>(
              builder: (context, state) {
                List<MenuItem> visibleItems =
                    state.items
                        .where(
                          (item) => state.visibilityFlags![item.title] == true,
                        )
                        .toList();
                List<MenuItem> overflowItems =
                    state.items
                        .where(
                          (item) => state.visibilityFlags![item.title] == false,
                        )
                        .toList();

                return Row(
                  spacing: Spacing.xsmall,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...visibleItems.map(
                      (item) =>
                          _buildNavItem(item, context, state.selectedItem),
                    ),
                    // if (overflowItems.isNotEmpty)
                    //   Flexible(
                    //     child: _buildMoreMenu(
                    //       overflowItems,
                    //       context,
                    //       state.selectedItem,
                    //     ),
                    //   ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
    MenuItem item,
    BuildContext context,
    String selectedItem,
  ) {
    return InkWell(
      onTap: () {
        // context.read<NavbarCubit>().selectItem(item);
        context.go(item.route!);
      },
      child: NavBarItemWidget(
        isSelected: item.title == selectedItem || item.title == '',
        isBottomNav: widget.isBottomNav,
        title: item.title,
        iconData: item.icon,
        svg: item.svg,
        onPressed: () {
          // context.read<NavbarCubit>().selectItem(item);
          context.go(item.route!);
        },
      ),
    );
  }

  // Widget _buildMoreMenu(
  //     List<MenuItem> overflowItems, BuildContext context, String selectedItem) {
  //   return widget.isBottomNav
  //       ? ConstrainedBox(
  //           constraints: BoxConstraints(
  //               maxWidth: getSizeMap(
  //                     context,
  //                     60,
  //                     60,
  //                     120,
  //                     120,
  //                     120,
  //                     120,
  //                   ) ??
  //                   120,
  //               minWidth: 60),
  //           child: NavBarItemWidget(
  //             isSelected: 'More' == selectedItem,
  //             isBottomNav: true,
  //             title: 'More',
  //             iconData: Icons.more_vert,
  //             onPressed: () {
  //               // context.go(AppRoutes.more);
  //             },
  //           ),
  //         )
  //       : DropdownButtonHideUnderline(
  //           child: DropdownButton2(
  //             // customButton: NavBarItemWidget(
  //             //   isSelected: false,
  //             //   isBottomNav: widget.isBottomNav,
  //             //   title: 'More',
  //             //   iconData: Icons.more_vert,
  //             // ),
  //             // openWithLongPress: true,
  //             items: overflowItems
  //                 .where((item) => item.title != 'More')
  //                 .map((item) => DropdownMenuItem<MenuItem>(
  //                       value: item,
  //                       child: Text(
  //                         item.title,
  //                         style: const TextStyle(
  //                           fontSize: 14,
  //                         ),
  //                       ),
  //                     ))
  //                 .toList(),
  //             onChanged: (item) {
  //               context.read<NavbarCubit>().toggleItemVisibility(item!);
  //               context.read<NavbarCubit>().selectItem(item);
  //               context.go(item.route!);
  //             },

  //             dropdownStyleData: DropdownStyleData(
  //               width: 160,
  //               padding: const EdgeInsets.symmetric(vertical: 6),
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(4),
  //                 color: Colors.white,
  //               ),
  //               offset: const Offset(40, -4),
  //             ),
  //           ),
  //         );
  // }
}

updateMenuFromRoute(
  BuildContext context,
  String id,
  double availableWidth, {
  String? route,
}) {
  bool mainRoute = true;
  MenuItem? initialRoute;
  final String currentRoute = route ?? GoRouterState.of(context).fullPath!;
  String? selected = context.read<NavbarCubit>().state.selectedItem;
  // log(
  //   'Route is $currentRoute ${getBaseRoute(currentRoute)}',
  // );
  List<MenuItem> menuItems = [];

  if (currentRoute.startsWith('/opportunities/lead')) {
    // menuItems = getCustomerMenuItems(id);
    mainRoute = false;
  } else if (currentRoute.startsWith('/inventory/details')) {
    // menuItems = getInventoryMenuItems(id);
    mainRoute = false;
  } else {
    // menuItems = mainMenuItems;

    if (getBaseRoute(currentRoute) == 'more') {
      if (!menuItems.any((menuItem) => menuItem.title == 'More')) {
        menuItems.add(const MenuItem(title: 'More', isVisible: false));
      }
    }
    if (menuItems.isNotEmpty) {
      initialRoute = menuItems.firstWhere(
        (item) => item.title.toLowerCase() == getBaseRoute(currentRoute),
        orElse: () => menuItems.first,
      );
    }
  }
  if (menuItems.isNotEmpty) {
    context.read<NavbarCubit>().updateNavbarItems(menuItems, availableWidth);
  }

  if (menuItems.isNotEmpty && selected == '' && !mainRoute) {
    int initialIndex = menuItems.indexWhere((item) => item.title.isNotEmpty);
    if (initialIndex != -1) {
      initialRoute = menuItems[initialIndex];
    }
  }
  if (initialRoute != null) {
    // log('Initial ${initialRoute.title} $selected');
    context.read<NavbarCubit>().selectItem(initialRoute);
  }
}

String getBaseRoute(String route) {
  List<String> segments = route.split('/').where((s) => s.isNotEmpty).toList();

  int takeCount =
      (segments.length > 2)
          ? 2
          : 1; // Take 2 if more than 2 segments exist, otherwise take 1
  String baseRoute = segments.take(takeCount).join('/');

  // log('$route baseRoutetrtrtrtr: $baseRoute');
  return baseRoute;
}
