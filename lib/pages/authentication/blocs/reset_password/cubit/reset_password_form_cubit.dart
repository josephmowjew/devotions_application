import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:devotions_app/pages/authentication/blocs/reset_password/reset_password_bloc.dart';

part 'reset_password_form_state.dart';

class ResetPasswordFormCubit extends Cubit<ResetPasswordFormState> {
  final ResetPasswordBloc resetPasswordBloc;

  ResetPasswordFormCubit({required this.resetPasswordBloc})
      : super(const ResetPasswordFormState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  submitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      resetPasswordBloc.add(
        ChangePasswordSubmitted(
          confirmPassword: state.confirmNewPassword ?? '',
          newPassword: state.password ?? '',
          token: state.token ?? "",
        ),
      );
    } else {
      state.copyWith(isAutoValidate: true);
    }
  }

  void saveToken(String? token) {
    log(token ?? 'no token');
    if (token != null) {
      emit(state.copyWith(token: token.trim()));
    }
  }

  void savePassword(String? password) {
    if (password != null) {
      emit(state.copyWith(password: password.trim()));
    }
  }

  void saveConfirmPassword(String? password) {
    if (password != null) {
      emit(state.copyWith(confirmNewPassword: password.trim()));
    }
  }

  void showPassword(bool password) {
    emit(state.copyWith(showPassword: !password));
  }

  void showConfirmPassword(bool password) {
    emit(state.copyWith(showConfirmPassword: !password));
  }
}

class PasswordStrengthCubit extends Cubit<PasswordStrengthState> {
  PasswordStrengthCubit() : super(const PasswordStrengthState());

  final RegExp upperCase = RegExp(r'[A-Z]');
  final RegExp lowerCase = RegExp(r'[a-z]');
  final RegExp numReg = RegExp(r'\d');
  final RegExp symbols = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  void checkPassword(String value) {
    String trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      emit(const PasswordStrengthState(
        strength: 0,
        displayText: 'Please enter your password',
      ));
    } else if (!upperCase.hasMatch(trimmedValue)) {
      emit(const PasswordStrengthState(
        strength: 1 / 4,
        displayText: 'Password must contain at least one uppercase letter',
      ));
    } else if (!lowerCase.hasMatch(trimmedValue)) {
      emit(const PasswordStrengthState(
        strength: 2 / 4,
        displayText: 'Password must contain at least one lowercase letter',
      ));
    } else if (!numReg.hasMatch(trimmedValue)) {
      emit(const PasswordStrengthState(
        strength: 3 / 4,
        displayText: 'Password must contain at least one numeric character',
      ));
    } else if (!symbols.hasMatch(trimmedValue)) {
      emit(const PasswordStrengthState(
        strength: 3 / 4,
        displayText: 'Password must contain at least one special character',
      ));
    } else if (trimmedValue.length < 8) {
      emit(const PasswordStrengthState(
        strength: 3 / 4,
        displayText: 'Password must be at least 8 characters long',
      ));
    } else {
      emit(const PasswordStrengthState(
        strength: 1,
        displayText: '',
      ));
    }
  }
}

class PasswordStrengthState {
  final double strength;
  final String displayText;

  const PasswordStrengthState({this.strength = 0, this.displayText = ''});
}
