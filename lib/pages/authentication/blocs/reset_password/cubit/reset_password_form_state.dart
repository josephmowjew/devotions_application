part of 'reset_password_form_cubit.dart';

class ResetPasswordFormState extends Equatable {
  const ResetPasswordFormState({
      this.password,
      this.confirmNewPassword,
      this.token,
      this.isAutoValidate = false,
      this.showPassword = false,
      this.showConfirmPassword = false
      
      });
  final String? password;
  final String? confirmNewPassword;
  final bool isAutoValidate;
  final bool showPassword;
  final bool showConfirmPassword;
  final String? token;
  @override
  List<Object?> get props => [
        password,
        confirmNewPassword,
        isAutoValidate,
        showPassword,
        showConfirmPassword,
        token,
      ];

  ResetPasswordFormState copyWith({
    String? password,
    String? confirmNewPassword,
    bool? isAutoValidate,
    bool? showPassword,
    bool? showConfirmPassword,
    String? token,
  }) {
    return ResetPasswordFormState(
      password: password ?? this.password,
      confirmNewPassword: confirmNewPassword ?? this.confirmNewPassword,
      isAutoValidate: isAutoValidate ?? this.isAutoValidate,
      showPassword: showPassword ?? this.showPassword,
      showConfirmPassword: showConfirmPassword ?? this.showConfirmPassword,
      token: token ?? this.token,
    );
  }
}
