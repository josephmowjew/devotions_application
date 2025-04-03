import 'package:flutter/material.dart';
import 'package:devotions_app/pages/authentication/components/widgets/authentication_page.dart';
import 'package:devotions_app/pages/authentication/components/widgets/forgot_password_form.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthenticationPage(
      title: 'Reset Password',
      form: ForgotPasswordForm(),
    );
  }
}
