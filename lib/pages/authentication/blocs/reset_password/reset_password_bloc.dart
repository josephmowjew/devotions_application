import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:devotions_app/shared/models/authentication/auth_modals.dart';
import 'package:devotions_app/shared/datasources/authentication_service/authentication_repository/authentication_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ChangePasswordState> {
  final AuthenticationRepository authenticationRepository;

  ResetPasswordBloc({required this.authenticationRepository})
    : super(ChangePasswordInitial()) {
    on<ChangePasswordSubmitted>(_changePassword);
  }

  Future<void> _changePassword(
    ChangePasswordSubmitted event,
    Emitter<ChangePasswordState> emit,
  ) async {
    try {
      emit(ChangePasswordLoading());
      final result = await authenticationRepository.resetPassword(
        event.token,
        ResetPasswordDto(password: event.newPassword),
      );

      result.fold(
        (failure) {
          log(failure.message);
          emit(ChangePasswordError(errorMessage: failure.message));
        },
        (resetSuccess) {
          emit(ChangePasswordSuccess());
        },
      );
    } catch (e) {
      emit(
        ChangePasswordError(
          errorMessage: "Change password error: ${e.toString()}",
        ),
      );
    }
  }
}
