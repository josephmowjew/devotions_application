import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devotions_app/pages/authentication/blocs/two_factor/two_factor_bloc.dart';
import 'package:devotions_app/pages/authentication/components/widgets/login_error.dart';
import 'package:devotions_app/routing/authentication_routes.dart';
import 'package:go_router/go_router.dart';
import 'package:lyvepulse_components/lyvepulse_components.dart';

class TwoFactorForm extends StatefulWidget {
  const TwoFactorForm({super.key});
  @override
  State<TwoFactorForm> createState() => _TwoFactorFormState();
}

class _TwoFactorFormState extends State<TwoFactorForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController twofactorCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Text(
            "Enter the security code we've sent to \nyou",
            style: AppTypographyy.textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
          BlocBuilder<TwoFactorBloc, TwoFactorState>(
            builder: (context, state) {
              return (state is TwoFactorFailure)
                  ? LoginError(message: state.errorMessage)
                  : const SizedBox();
            },
          ),
          const SizedBox(height: Spacing.small),
          CustomInputField(
            hintText: 'Code*',
            maxLines: 1,
            isPassword: false,
            keyboardType: TextInputType.number,
            isOutlined: true,
            suffixIcon: const Icon(Icons.cancel_outlined),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            controller: twofactorCode,
            validator: validateCode,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
          const SizedBox(height: Spacing.large),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  context.go(AuthRoutes.login);
                },
                child: Text(
                  'Back to Login',
                  style: AppTypographyy.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.small),
          BlocConsumer<TwoFactorBloc, TwoFactorState>(
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: CustomButton(
                  height: 50,
                  color: AppColors.primary,
                  label: 'Reset',
                  onClick: () {
                    context.read<TwoFactorBloc>().add(
                      TwoFactorSubmitted(
                        username: "",
                        securityCode: twofactorCode.text,
                      ),
                    );
                  },
                  isLoading: state is TwoFactorLoading,
                  isOutlined: false,
                ),
              );
            },
            listener: (BuildContext context, TwoFactorState state) {
              if (state is TwoFactorSuccess) {
                context.go(AuthRoutes.login);
              }
            },
          ),
        ],
      ),
    );
  }

  static String? validateCode(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Enter a valid security code";
    }

    if (int.tryParse(value) != null) {
      return null;
    }

    return "Not a valid number";
  }
}
