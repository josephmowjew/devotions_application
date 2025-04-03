import 'package:flutter/material.dart';
import 'package:devotions_app/pages/authentication/components/widgets/authentication_page.dart';
import 'package:devotions_app/pages/authentication/components/widgets/reset_success_form.dart';

class ForgotPasswordSuccess extends StatelessWidget {
  final String? email;
  const ForgotPasswordSuccess({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    return AuthenticationPage(
      title: 'Message Sent',
      form: ResetSuccessForm(email: email ?? ''),
    );
  }
}
