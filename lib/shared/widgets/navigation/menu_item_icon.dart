
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuItemIcon extends StatelessWidget {
  final IconData? icon;
  final String? svg;
  final bool isSelected;
  final Color color;

  const MenuItemIcon({
    super.key,
    this.icon,
    this.svg,
    required this.isSelected,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {

    return svg == null
        ? Icon(
            icon,
            color: color,
            size: 22,
          )
        : SizedBox(
          child: SvgPicture.string(
              height: 20,
              width: 20,
              fit: BoxFit.scaleDown,
              svg!,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
        );
  }
}
