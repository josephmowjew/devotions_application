import 'package:flutter/material.dart';
import 'package:devotions_app/routing/authentication_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:lyvepulse_components/lyvepulse_components.dart';

class ResetSuccessForm extends StatelessWidget {
  final String email;
  const ResetSuccessForm({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'An email was sent to \n$email with \nthe instructions for resetting your \npassword',
          style: AppTypographyy.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: Spacing.large),
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            height: 50,
            color: AppColors.primary,
            label: 'Close',
            isOutlined: false,
            onClick: () {
              context.go(AuthRoutes.login);
            },
          ),
        ),
      ],
    );
  }
}
