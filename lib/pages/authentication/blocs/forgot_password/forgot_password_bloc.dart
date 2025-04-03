import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:devotions_app/shared/datasources/authentication_service/authentication_repository/authentication_repository.dart';

part 'forgot_password_event.dart';
part 'reset_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ResetPasswordState> {
  final AuthenticationRepository authenticationRepository;

  ForgotPasswordBloc({required this.authenticationRepository})
    : super(ResetPasswordInitial()) {
    on<ResetPasswordAction>(_restPasswordAction);
  }

  Future<void> _restPasswordAction(
    ResetPasswordAction event,
    Emitter<ResetPasswordState> emit,
  ) async {
    try {
      emit(ResetPasswordLoading());
      final result = await authenticationRepository.forgotPassword(
        event.username,
      );
      result.fold(
        (failure) {
          emit(ResetPasswordFailure(errorMessage: failure.message));
        },
        (success) {
          emit(ResetPasswordSuccess());
        },
      );
    } catch (e) {
      emit(
        ResetPasswordFailure(
          errorMessage: "Reset Password Error ${e.toString()}",
        ),
      );
    }
  }
}
