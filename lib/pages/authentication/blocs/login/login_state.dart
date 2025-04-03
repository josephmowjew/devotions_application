part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserProfile? userProfile;
  const LoginSuccess({this.userProfile});
}

final class LoginFailure extends LoginState {
  final String errorMessage;
  const LoginFailure({required this.errorMessage});
}
