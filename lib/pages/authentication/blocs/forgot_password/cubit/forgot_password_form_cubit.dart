import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:devotions_app/pages/authentication/blocs/forgot_password/forgot_password_bloc.dart';

part 'forgot_password_form_state.dart';

class ForgotPasswordFormCubit extends Cubit<ForgotPasswordFormState> {
  final ForgotPasswordBloc forgotBloc;
  TextEditingController emailController = TextEditingController();

  ForgotPasswordFormCubit({required this.forgotBloc})
    : super(const ForgotPasswordFormState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      forgotBloc.add(ResetPasswordAction(username: state.email ?? ''));
    } else {
      state.copyWith(isAutoValidate: true);
    }
  }

  void saveEmail(String? email) {
    if (email != null) {
      emit(state.copyWith(email: email.trim()));
    }
  }

  void clearEmail() {
    emailController.clear();
    emit(state.clearEmail());
  }
}
