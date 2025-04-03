import 'package:flutter/material.dart';
import 'package:lyvepulse_components/lyvepulse_components.dart';

class ResetFormHeader extends StatelessWidget {
  const ResetFormHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.darkGrey2,
          ),
          padding: const EdgeInsets.all(Spacing.small),
          child: const Icon(
            Icons.person,
            color: AppColors.black,
            size: 24,
          ),
        ),
        const SizedBox(
          height: Spacing.small,
        ),
        Text(
          'Hi,',
          style: AppTypographyy.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: Spacing.small,
        ),
        Text(
          'Your password is due for reset',
          style: AppTypographyy.textTheme.bodySmall,
        ),
        const SizedBox(
          height: Spacing.small,
        ),
      ],
    );
  }
}
