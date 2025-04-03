part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});  
}

class BiometricLogin extends LoginEvent {}

class LogoutUserEvent extends LoginEvent {}
