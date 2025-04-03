import 'package:flutter/material.dart';
import 'package:devotions_app/pages/authentication/components/views/login/login_page.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return DeviceTypeUtils.isMobileDevice(context) ?
    //   buildMobileLayout()
    // : buildDesktopLayout();
    return const LoginPage();
  }
}
