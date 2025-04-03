import 'package:flutter/material.dart';
import 'package:devotions_app/pages/authentication/components/widgets/authentication_page.dart';
import 'package:devotions_app/pages/authentication/components/widgets/reset_password_form.dart';

class ResetPassword extends StatelessWidget {
  final String? token;
  const ResetPassword({super.key, this.token});

  @override
  Widget build(BuildContext context) {
    return AuthenticationPage(
      title: 'Reset Password',
      form: ResetPasswordForm(token: token),
      showTitle: false,
    );
  }
}
