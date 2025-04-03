import 'package:flutter/material.dart';
import 'package:devotions_app/routing/authentication_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:lyvepulse_components/form_components/widgets/custom_text.dart';
import 'package:lyvepulse_components/lyvepulse_components.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const CustomInputField(
            hintText: 'Email Address*',
            maxLines: 1,
            isPassword: false,
            keyboardType: TextInputType.emailAddress,
            isOutlined: true,
            suffixIcon: Icon(Icons.cancel_outlined),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
          // SizedBox(
          //   height: Spacing.medium,
          // ),
          const CustomInputField(
            hintText: 'Password*',
            maxLines: 1,
            isPassword: true,
            keyboardType: TextInputType.visiblePassword,
            isOutlined: true,
            suffixIcon: Icon(Icons.visibility_off),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
          const SizedBox(height: Spacing.medium),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  context.go(AuthRoutes.forgotPassword);
                },
                child: const CustomText(
                  textColor: AppColors.primary,
                  textLabel: 'Forgot Password',
                  textSize: 14,
                  textFontFamily: 'Poppins',
                  textFontWeight: FontWeight.normal,
                  textDecoration: TextDecoration.none,
                  letterSpacing: 0.15,
                  height: 0,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.large),
          const SizedBox(
            width: double.infinity,
            child: CustomButton(
              height: 50,
              color: AppColors.primary,
              label: 'Login',
              isOutlined: false,
            ),
          ),
        ],
      ),
    );
  }
}
