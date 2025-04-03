import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devotions_app/pages/authentication/blocs/forgot_password/cubit/forgot_password_form_cubit.dart';
import 'package:devotions_app/pages/authentication/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:devotions_app/routing/authentication_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:lyvepulse_components/lyvepulse_components.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    var form = context.read<ForgotPasswordFormCubit>();

    return Form(
      key: form.formKey,
      autovalidateMode:
          form.state.isAutoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
      child: Column(
        children: [
          CustomInputField(
            hintText: 'Email Address*',
            keyboardType: TextInputType.emailAddress,
            suffixIcon: IconButton(
              icon: const Icon(Icons.cancel_outlined),
              onPressed: () {
                form.clearEmail();
              },
            ),
            onChanged: form.saveEmail,
            onSaved: form.saveEmail,
            validator: ValidationUtils.validateEmail,
            autovalidateMode: AutovalidateMode.onUnfocus,
            controller: form.emailController,
          ),
          const SizedBox(height: Spacing.medium),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  context.go(AuthRoutes.login);
                },
                child: Text(
                  'Back to Login',
                  style: AppTypographyy.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.normal,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.small),
          BlocConsumer<ForgotPasswordBloc, ResetPasswordState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: CustomButton(
                  height: 50,
                  color: AppColors.primary,
                  label: 'Reset Password',
                  onClick: () => form.submitForm(),
                  isLoading: state is ResetPasswordLoading,
                  isOutlined: false,
                ),
              );
            },
            listener: (BuildContext context, ResetPasswordState state) {
              if (state is ResetPasswordSuccess) {
                context.go(
                  AuthRoutes.resetSuccess,
                  extra: {'email': form.state.email ?? ''},
                );
              }
            },
          ),
          const SizedBox(height: Spacing.large),
        ],
      ),
    );
  }
}
