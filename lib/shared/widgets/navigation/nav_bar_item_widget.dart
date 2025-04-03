import 'package:flutter/material.dart';
import 'package:devotions_app/shared/utils/get_size_map.dart';
import 'package:devotions_app/shared/widgets/navigation/menu_item_icon.dart';
import 'package:lyvepulse_components/lyvepulse_components.dart';

class NavBarItemWidget extends StatelessWidget {
  const NavBarItemWidget({
    super.key,
    required this.isBottomNav,
    required this.isSelected,
    required this.title,
    this.iconData,
    this.svg,
    this.onPressed,
  });

  final bool isBottomNav;
  final bool isSelected;
  final String title;
  final IconData? iconData;
  final String? svg;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // spacing: 8,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(
                left: getSizeMap(context, 0, 0, 24, 24, 24, 24) ?? 0,
                right: getSizeMap(context, 0, 0, 24, 24, 24, 24) ?? 0,
              ),
              padding: EdgeInsets.only(bottom: !isBottomNav ? 12 : 0),
              decoration:
                  !isBottomNav
                      ? BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color:
                                (isSelected && title.isNotEmpty)
                                    ? AppColors.accent
                                    : AppColors.primary,
                            width: 2,
                          ),
                        ),
                      )
                      : null,
              child: TextButton(
                onPressed: onPressed,
                child:
                    !isBottomNav
                        ? Row(
                          spacing: 6,
                          children: [
                            if (iconData != null || svg != null)
                              MenuItemIcon(
                                isSelected: isSelected,
                                icon: iconData,
                                svg: svg,
                                color:
                                    isSelected
                                        ? AppColors.accent
                                        : Colors.white,
                              ),
                            Text(
                              title,
                              style: TextStyle(
                                color:
                                    isSelected
                                        ? AppColors.accent
                                        : AppColors.white,
                              ),
                            ),
                          ],
                        )
                        : Column(
                          children: [
                            Container(
                              width: 64,
                              height: 32,
                              decoration:
                                  isSelected
                                      ? ShapeDecoration(
                                        color: const Color(0xFFDBE2F9),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                        ),
                                      )
                                      : null,
                              child: MenuItemIcon(
                                isSelected: isSelected,
                                icon: iconData,
                                svg: svg,
                                color:
                                    isSelected
                                        ? AppColors.primary
                                        : const Color(0xffacacac),
                              ),
                            ),
                            Text(
                              title,
                              style: TextStyle(
                                color:
                                    isSelected
                                        ? AppColors.primary
                                        : const Color(0xffacacac),
                              ),
                            ),
                          ],
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
