import 'package:flutter/material.dart';
import 'package:lyvepulse_components/lyvepulse_components.dart';

class LoginError extends StatelessWidget {
  final String message;
  const LoginError({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.only(bottom: Spacing.medium),
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Expanded(
              //   child: Text(
              //     "The email / password combination does not match. Please try again.",
              //     style: AppTypography.textTheme.bodySmall
              //   ),
              // ),
             Expanded(
                child: Text(
                  message,
                  style: AppTypographyy.textTheme.bodySmall
                ),
              ),
            ],
          ),
        );
  }
}
