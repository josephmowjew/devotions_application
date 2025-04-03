part of 'forgot_password_form_cubit.dart';

class ForgotPasswordFormState extends Equatable {
  const ForgotPasswordFormState({
    this.email,
    this.isAutoValidate = false,
  });
  final String? email;
  final bool isAutoValidate;
  @override
  List<Object?> get props => [
        email,
        isAutoValidate,
      ];

  ForgotPasswordFormState copyWith({
    String? email,
    String? password,
    bool? isAutoValidate,
    bool? showPassword,
  }) {
    return ForgotPasswordFormState(
      email: email ?? this.email,
      isAutoValidate: isAutoValidate ?? this.isAutoValidate,
    );
  }
   ForgotPasswordFormState clearEmail() {
    return copyWith(
      email: '',
    );
  }
}
