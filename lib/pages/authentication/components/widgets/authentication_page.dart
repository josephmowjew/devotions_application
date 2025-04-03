import 'package:flutter/material.dart';
import 'package:devotions_app/pages/authentication/components/widgets/authentication_form_section.dart';
import 'package:devotions_app/pages/authentication/components/widgets/authentication_image_section.dart';
import 'package:devotions_app/shared/utils/get_size_map.dart';

import 'package:lyvepulse_components/lyvepulse_components.dart';
import 'package:lyvepulse_components/utils/device_type_utils.dart';

class AuthenticationPage extends StatelessWidget {
  final String title;
  final Widget form;
  final bool? showTitle;
  const AuthenticationPage({
    super.key,
    required this.title,
    required this.form,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = DeviceTypeUtils.getDeviceType(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = constraints.maxHeight;
        final screenWidth = constraints.maxWidth;
        return Material(
          color: AppColors.white,
          child: Row(
            children: [
              // if (deviceType != DeviceType.mobile &&
              //     deviceType != DeviceType.smallTablet)
              // Expanded(
              //   flex: getSizeMap(context, 5, 5, 5, 6, 6, 9)?.toInt() ?? 6,
              //   child: AuthenticationImageSection(),
              // ),
              Expanded(
                flex: getSizeMap(context, 5, 5, 5, 4, 4, 4)?.toInt() ?? 4,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: AuthenticationFormSection(
                    height: screenHeight,
                    width: screenWidth,
                    title: title,
                    form: form,
                    showTitle: showTitle ?? true,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
