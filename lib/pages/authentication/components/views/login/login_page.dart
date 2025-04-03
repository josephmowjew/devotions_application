import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devotions_app/pages/authentication/blocs/login/cubit/login_form_cubit.dart';
import 'package:devotions_app/pages/authentication/blocs/login/login_bloc.dart';
import 'package:devotions_app/pages/authentication/components/widgets/authentication_page.dart';
import 'package:devotions_app/pages/authentication/components/widgets/login_error.dart';
import 'package:devotions_app/routing/authentication_routes.dart';
import 'package:devotions_app/routing/main_routes.dart';
import 'package:devotions_app/shared/models/authentication/config.dart';
import 'package:go_router/go_router.dart';
import 'package:lyvepulse_components/lyvepulse_components.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final deviceType = DeviceTypeUtils.getDeviceType(context);

    var form = context.watch<LoginFormCubit>();
    return AuthenticationPage(
      title: 'Sign In',
      form: Column(
        children: [
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return (state is LoginFailure)
                  ? LoginError(message: state.errorMessage)
                  : const SizedBox();
            },
          ),
          Form(
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
                CustomInputField(
                  hintText: 'Password*',
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
                  onChanged: form.savePassword,
                  onSaved: form.savePassword,
                  validator:
                      (value) => ValidationUtils.validateRequiredField(
                        value,
                        'Please enter password',
                      ),
                ),
                const SizedBox(height: Spacing.large),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.go(AuthRoutes.forgotPassword);
                      },
                      child: Text(
                        'Forgot Password',
                        style: AppTypographyy.textTheme.labelLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Spacing.small),
                BlocConsumer<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        CustomButton(
                          color: AppColors.primary,
                          label: 'Login',
                          onClick: () => form.submitForm(),
                          isWide: true,
                          isLoading: state is LoginLoading,
                          isOutlined: false,
                          height: 45,
                        ),
                        const SizedBox(height: Spacing.large),
                        // if (deviceType == DeviceType.mobile)
                        //   GestureDetector(
                        //     onTap: () {
                        //       context.read<LoginBloc>().add(BiometricLogin());
                        //     },
                        //     child: Column(
                        //       children: [
                        //         Icon(Icons.fingerprint_outlined, size: 48,),
                        //         const Text("Login with Biometrics"),
                        //       ],
                        //     ),
                        //   )
                      ],
                    );
                  },
                  listener: (BuildContext context, LoginState state) async {
                    if (state is LoginSuccess) {
                      Config? config = state.userProfile?.config;
                      if (config != null && config.twoFactorEnabled == true) {
                        context.replace(AuthRoutes.twofactorAuth);
                      } else {
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           const SplashScreen(home: Text("data"))),
                        // );
                        context.go(AppRoutes.initial);
                        // context.replace(AppRoutes.home);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
