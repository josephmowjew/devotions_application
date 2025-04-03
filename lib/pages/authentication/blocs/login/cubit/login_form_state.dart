part of 'login_form_cubit.dart';

class LoginFormState extends Equatable {
  const LoginFormState({
    this.email,
    this.password,
    this.isAutoValidate = false,
    this.showPassword = false,
  });
  final String? email;
  final String? password;
  final bool isAutoValidate;
  final bool showPassword;
  @override
  List<Object?> get props => [
        email,
        password,
        isAutoValidate,
        showPassword,
      ];

  LoginFormState copyWith({
    String? email,
    String? password,
    bool? isAutoValidate,
    bool? showPassword,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isAutoValidate: isAutoValidate ?? this.isAutoValidate,
      showPassword: showPassword ?? this.showPassword,
    );
  }

  LoginFormState clearEmail() {
    return copyWith(
      email: '',
    );
  }
}
