import 'package:flutter/material.dart';
import 'package:devotions_app/pages/authentication/components/widgets/authentication_page.dart';
import 'package:devotions_app/pages/authentication/components/widgets/two_factor_form.dart';

class TwoFactor extends StatefulWidget {
  const TwoFactor({super.key});

  @override
  State<TwoFactor> createState() => _TwoFactorState();
}

class _TwoFactorState extends State<TwoFactor> {
  @override
  Widget build(BuildContext context) {
    return const AuthenticationPage(
      title: 'Two Factor \nAuthentication',
      form: TwoFactorForm(),
    );
  }
}
