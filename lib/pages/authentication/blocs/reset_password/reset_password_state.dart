part of 'reset_password_bloc.dart';

sealed class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordLoading extends ChangePasswordState {}

final class ChangePasswordSuccess extends ChangePasswordState {}

final class ChangePasswordError extends ChangePasswordState {
  final String errorMessage;
  const ChangePasswordError({required this.errorMessage});
}
