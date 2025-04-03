import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devotions_app/pages/authentication/blocs/reset_password/cubit/reset_password_form_cubit.dart';
import 'package:devotions_app/pages/authentication/blocs/reset_password/reset_password_bloc.dart';
import 'package:devotions_app/pages/authentication/components/widgets/login_error.dart';
import 'package:devotions_app/routing/authentication_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:lyvepulse_components/lyvepulse_components.dart';

class ResetPasswordForm extends StatefulWidget {
  final String? token;
  const ResetPasswordForm({super.key, this.token});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  @override
  Widget build(BuildContext context) {
    var form = context.watch<ResetPasswordFormCubit>();
    form.saveToken(widget.token);
    return BlocProvider(
      create: (context) => PasswordStrengthCubit(),
      child: Column(
        children: [
          // Reset form header
          // ResetFormHeader(),
          BlocBuilder<ResetPasswordBloc, ChangePasswordState>(
            builder: (context, state) {
              return (state is ChangePasswordError)
                  ? LoginError(message: state.errorMessage)
                  : const SizedBox();
            },
          ),
          BlocBuilder<PasswordStrengthCubit, PasswordStrengthState>(
            builder: (context, state) {
              Color progressColor;

              // Determine the color based on the password strength
              if (state.strength == 0) {
                progressColor = AppColors.red; // Weak or empty password
              } else if (state.strength <= 0.25) {
                progressColor = AppColors.orange; // Weak
              } else if (state.strength <= 0.5) {
                progressColor = AppColors.accent; // Moderate
              } else if (state.strength <= 0.75) {
                progressColor = AppColors.secondary; // Strong
              } else {
                progressColor = AppColors.primary; // Very strong
              }

              return Form(
                key: form.formKey,
                autovalidateMode:
                    form.state.isAutoValidate
                        ? AutovalidateMode.always
                        : AutovalidateMode.disabled,
                child: Column(
                  children: [
                    const SizedBox(height: Spacing.large),
                    CustomInputField(
                      hintText: 'New Password*',
                      isPassword: !form.state.showPassword,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          form.showPassword(form.state.showPassword);
                        },
                        icon: Icon(
                          form.state.showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      // onChanged: form.savePassword,
                      onSaved: form.savePassword,
                      errorText:
                          state.displayText.isNotEmpty
                              ? state.displayText
                              : null,

                      // onChanged: _savePassword,
                      onChanged: (val) {
                        form.savePassword(val);
                        context.read<PasswordStrengthCubit>().checkPassword(
                          val,
                        );
                      },
                      // validator: (value) => ValidationUtils.validateRequiredField(
                      //     value, 'Please enter password'),
                      validator:
                          (v) => ValidationUtils.validateStrongPassword(v),
                    ),
                    const SizedBox(height: Spacing.medium),
                    CustomInputField(
                      hintText: 'Confirm Password*',
                      isPassword: !form.state.showConfirmPassword,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          form.showConfirmPassword(
                            form.state.showConfirmPassword,
                          );
                        },
                        icon: Icon(
                          form.state.showConfirmPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      onChanged: form.saveConfirmPassword,
                      onSaved: form.saveConfirmPassword,
                      validator:
                          (value) => ValidationUtils.confirmPasswordValidator(
                            form.state.password ?? '',
                            value ?? '',
                          ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                    ),
                    const SizedBox(height: 16),
                    // The strength indicator bar
                    // LinearProgressIndicator(
                    //   value: _strength,
                    //   backgroundColor: Colors.grey[300],
                    //   color: _strength <= 1 / 4
                    //       ? AppColors.orange
                    //       : _strength == 2 / 4
                    //           ? AppColors.orange
                    //           : _strength == 3 / 4
                    //               ? AppColors.secondary
                    //               : AppColors.primary,
                    //   minHeight: 8,
                    // ),
                    LinearProgressIndicator(
                      value: state.strength,
                      backgroundColor: Colors.grey[300],
                      valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                    ),

                    const SizedBox(height: Spacing.large),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.go(AuthRoutes.login);
                          },
                          child: Text(
                            'Back to Login',
                            style: AppTypographyy.textTheme.labelLarge
                                ?.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    BlocConsumer<ResetPasswordBloc, ChangePasswordState>(
                      builder: (context, state) {
                        return SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            height: 50,
                            color: AppColors.primary,
                            label: 'Reset',
                            onClick: () => form.submitForm(),
                            isLoading: state is ChangePasswordLoading,
                            isOutlined: false,
                          ),
                        );
                      },
                      listener: (
                        BuildContext context,
                        ChangePasswordState state,
                      ) {
                        if (state is ChangePasswordSuccess) {
                          context.go(AuthRoutes.login);
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Hint: ',
                              style: AppTypographyy.textTheme.bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(
                              text:
                                  'Password must contain at least 1 uppercase character, 1 lowercase character, 1 special character, 1 number and have a length of at least 8 characters',
                              style: AppTypographyy.textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
