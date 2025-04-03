import 'package:flutter/material.dart';
import 'package:lyvepulse_components/lyvepulse_components.dart';
import 'package:lyvepulse_components/utils/device_type_utils.dart';

class DefaultLayout extends StatefulWidget {
  final Widget child;
  const DefaultLayout({super.key, required this.child});

  @override
  State<DefaultLayout> createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  // late AutoLogoutManager autoLogoutManager;

  @override
  void initState() {
    super.initState();
    // final loginBloc = context.read<LoginBloc>(); // Get the LoginBloc instance
    // autoLogoutManager = AutoLogoutManager(authenticationBloc: loginBloc);
  }

  @override
  void dispose() {
    // autoLogoutManager.dispose();
    super.dispose();
  }

  void resetInactivityTimer() {
    // autoLogoutManager.resetTimer();
  }

  @override
  Widget build(BuildContext context) {
    final deviceType = DeviceTypeUtils.getDeviceType(context);
    bool isMobileView =
        ![
          DeviceType.desktop,
          DeviceType.smallLaptop,
          DeviceType.largeLaptop,
        ].contains(deviceType);

    return MouseRegion(
      onHover: (_) => resetInactivityTimer(), // Reset timer on mouse movement
      child: GestureDetector(
        onTap: resetInactivityTimer, // Reset timer on tap
        onPanUpdate: (_) => resetInactivityTimer(), // Reset on drag (scroll)
        child: Scaffold(
          backgroundColor: !isMobileView ? Colors.white : AppColors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: widget.child,
            ),
          ),
          bottomNavigationBar: null, // Removing the NavigationMenuList for now
        ),
      ),
    );
  }
}
