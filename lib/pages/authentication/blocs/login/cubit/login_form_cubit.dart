import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:devotions_app/pages/authentication/blocs/login/login_bloc.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  final LoginBloc loginBloc;
  TextEditingController emailController = TextEditingController();

  LoginFormCubit({required this.loginBloc}) : super(const LoginFormState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      loginBloc.add(
        LoginSubmitted(
          email: state.email ?? '',
          password: state.password ?? '',
        ),
      );
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

  void savePassword(String? password) {
    if (password != null) {
      emit(state.copyWith(password: password.trim()));
    }
  }

  void showPassword(bool password) {
    emit(state.copyWith(showPassword: !password));
  }
}
