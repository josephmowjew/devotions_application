import 'package:css_units/css_units.dart';
import 'package:flutter/material.dart';
import 'package:devotions_app/shared/utils/get_size_map.dart';
import 'package:lyvepulse_components/lyvepulse_components.dart';

class AuthenticationFormSection extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final Widget form;
  final bool showTitle;

  const AuthenticationFormSection({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.form,
    required this.showTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal:
            getSizeMap(context, 20, 120, 40, 60, 70, 60) ??
            MediaQuery.of(context).size.width * 60,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // SvgPicture.asset(
          //   'assets/images/logo/logo.svg',
          //   fit: BoxFit.none,
          //   height: Spacing.xlarge.vh,
          //   width: Spacing.xlarge.vw,
          // ),
          const SizedBox(height: 24),
          if (showTitle)
            Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppTypographyy.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 24.vh),
              ],
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.vw),
            child: Column(children: [form]),
          ),
        ],
      ),
    );
  }
}
