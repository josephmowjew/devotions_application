import 'package:flutter/material.dart';
import 'package:devotions_app/shared/utils/get_size_map.dart';
import 'package:lyvepulse_components/lyvepulse_components.dart';

class AuthenticationImageSection extends StatelessWidget {
  const AuthenticationImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/login-bg.png', fit: BoxFit.cover),
        Opacity(opacity: 0.4, child: Container(color: Colors.black)),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to your',
                style: AppTypographyy.textTheme.displayMedium?.copyWith(
                  fontSize: getSizeMap(context, 45, 29, 30, 40, 43, 45),
                  // fontSize: deviceType ==  DeviceType.smallTablet ? 29 : 45,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: AppColors.white,
                  letterSpacing: 0,
                  height: 52 / 45,
                ),
              ),
              Text(
                'Next Gen Platform',
                style: AppTypographyy.textTheme.displayMedium?.copyWith(
                  fontSize: getSizeMap(context, 45, 29, 30, 40, 43, 45),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: AppColors.accent,
                  letterSpacing: 0,
                  height: 59 / 40,
                ),
              ),
              Text(
                'Your sales team will love it!',
                style: AppTypographyy.textTheme.displayMedium?.copyWith(
                  fontSize: getSizeMap(context, 45, 25, 30, 40, 43, 45),
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                  fontFamily: 'Poppins',
                  letterSpacing: 0,
                  height: 52 / 45,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
