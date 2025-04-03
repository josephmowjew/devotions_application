part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetPasswordAction extends ForgotPasswordEvent {
  final String username;
  const ResetPasswordAction({required this.username});
}
