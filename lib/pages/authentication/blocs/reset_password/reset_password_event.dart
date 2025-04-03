part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordSubmitted extends ResetPasswordEvent {
  final String confirmPassword;
  final String newPassword;
  final String token;

  const ChangePasswordSubmitted(
      {required this.confirmPassword, required this.newPassword,required this.token});
}
